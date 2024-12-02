from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy import Table, select, and_, func
from sqlalchemy.engine import Engine
from sqlalchemy.exc import IntegrityError
from database import get_db
from database import metadata
from enum import Enum
from pydantic import BaseModel

router = APIRouter()

class SkinTypeEnum(str, Enum):
    normal = 'normal'
    oily = 'oily'
    dry = 'dry'
    combination = 'combination'
    sensitive = 'sensitive'

class UserCreateModel(BaseModel):
    email: str
    username: str
    skinType: SkinTypeEnum

users_table = Table('Users', metadata)

@router.get("/{user_id}")
def get_user(user_id: int, db: Engine = Depends(get_db)):
    """
    Get user by user ID
    """
    stmt = select(users_table).where(users_table.c.userID == user_id)
    result = db.execute(stmt).all()
    if not result:
        raise HTTPException(
            status_code=404,
            detail="User not found"
        )
    return result[0]._mapping

@router.post("/")
def create_user(user: UserCreateModel, db: Engine = Depends(get_db)):
    """
    Insert a new user
    """
    stmt = users_table.insert().values(
        email=user.email,
        username=user.username,
        skinType=user.skinType.value
    )
    try:
        db.execute(stmt)
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(
            status_code=400,
            detail="A user with this email or username already exists."
        )
    return {"message": "User created"}
