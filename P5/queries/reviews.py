from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy import Table, select, and_, func
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

@router.post("/")
def create_review(review: dict, db: Engine = Depends(get_db)):
    """
    Insert a new review
    """
    if 'routineID' not in review or 'userID' not in review or 'reviewText' not in review or 'rating' not in review:
        raise HTTPException(
            status_code = 400,
            detail = "Needs routineID and userID and reviewText and rating"
        )
    stmt1 = select(routine_table).where(routine_table.c.routineID == review['routineID'])
    stmt2 = select(users_table).where(users_table.c.userID == review['userID'])
    result1 = db.execute(stmt1).all()
    result2 = db.execute(stmt2).all()
    if not result1:
        raise HTTPException(
            status_code = 400,
            detail = "RoutineID not found."
        )
    if not result2:
        raise HTTPException(
            status_code = 400,
            detail = "UserID not found."
        )
    stmt = reviews_table.insert().values(
        routineID = review['routineID'],
        userID = review['userID'],
        reviewText = review['reviewText'],
        publishDate=func.now(),
        rating = review['rating']
    )
    db.execute(stmt)
    db.commit()
    return {"message": "Review created successfully"}

@router.put("/{routine_id}/{user_id}")
def update_review(routine_id: int, user_id: int, review: dict, db: Engine = Depends(get_db)):
    """
    Update a review
    """
    stmt = reviews_table.update().where(and_(reviews_table.c.routineID == routine_id, reviews_table.c.userID == user_id)).values(
        reviewText = review['reviewText'],
        rating = review['rating'],
        publishDate=func.now()
    )
    db.execute(stmt)
    db.commit()
    return {"message": "Review updated successfully"}
