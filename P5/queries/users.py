from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy import Table, select, and_, func
from sqlalchemy.engine import Engine
from database import get_db
from database import metadata

router = APIRouter()

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
