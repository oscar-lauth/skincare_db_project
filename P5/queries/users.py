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

class UserUpdateModel(BaseModel):
    email: str | None = None
    username: str | None = None
    skinType: SkinTypeEnum | None = None

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

@router.put("/{user_id}")
def update_user(user_id: int, user: UserUpdateModel, db: Engine = Depends(get_db)):
    """
    Update a user
    """
    stmt = select(users_table).where(users_table.c.userID == user_id)
    existing_user = db.execute(stmt).fetchone()
    if not existing_user:
        raise HTTPException(status_code=404, detail="User not found")
    update_data = {key: value for key, value in user.model_dump(exclude_unset=True).items()}
    if update_data:
        update_stmt = users_table.update().where(users_table.c.userID == user_id).values(**update_data)
        db.execute(update_stmt)
    db.commit()
    return {"message": "User updated successfully"}

@router.delete("/{user_id}")
def delete_user(user_id: int, db: Engine = Depends(get_db)):
    """
    Delete a user
    """
    stmt = users_table.delete().where(users_table.c.userID == user_id)
    result = db.execute(stmt)
    db.commit()
    if result.rowcount == 0:
        raise HTTPException(status_code=404, detail="User not found")
    return {"message": "User deleted successfully"}
