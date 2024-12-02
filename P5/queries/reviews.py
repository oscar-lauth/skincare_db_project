from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy import Table, select, and_
from sqlalchemy.engine import Engine
from database import get_db
from database import metadata

router = APIRouter()

reviews_table = Table('Reviews', metadata)
routine_table = Table('Routine', metadata)
users_table = Table('Users', metadata)

@router.get("/routine/{routine_id}")
def get_reviews_by_routine(routine_id: int, db: Engine = Depends(get_db)):
    """
    Get reviews by routine ID
    """
    stmt = select(reviews_table).where(reviews_table.c.routineID == routine_id)
    result = db.execute(stmt).all()
    if not result:
        raise HTTPException(
            status_code = 404,
            detail = "This routine has no reviews"
        )
    return [row._mapping for row in result]

@router.get("/user/{user_id}")
def get_reviews_by_user(user_id: int, db: Engine = Depends(get_db)):
    """
    Get reviews by user ID
    """
    stmt = select(reviews_table).where(reviews_table.c.userID == user_id)
    result = db.execute(stmt).all()
    if not result:
        raise HTTPException(
            status_code = 404,
            detail = "This user has left no reviews"
        )
    return [row._mapping for row in result]
