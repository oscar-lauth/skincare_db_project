from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy import Table, select
from sqlalchemy.engine import Engine
from database import get_db

router = APIRouter()

from database import metadata

routine_table = Table('Routine', metadata)
user_table = Table('Users', metadata)
routine_has_table = Table('Has', metadata)

@router.get("/")
def get_products(db: Engine = Depends(get_db)):
    """
    Get all routines.
    """
    stmt = select(routine_table)
    result = [row._mapping for row in db.execute(stmt).all()]
    return result

@router.get("/{routine_id}")
def get_product(routine_id: int, db: Engine = Depends(get_db)):
    """
    Get a single routine by ID.
    """
    stmt = select(routine_table).where(routine_table.c.routineID == routine_id)
    result = db.execute(stmt).first()
    if not result:
        raise HTTPException(status_code=404, detail="Routine not found")
    routine_data = dict(result._mapping)
    routine_steps_stmt = select(routine_has_table.c.productID).where(routine_has_table.c.routineID == routine_id).order_by(routine_has_table.c.orderIndex)
    routine_steps_result = [step._mapping['productID'] for step in db.execute(routine_steps_stmt).all()]
    routine_data['productIDs'] = routine_steps_result
    return routine_data

@router.post("/")
def create_product(routine: dict, db: Engine = Depends(get_db)):
    """
    Insert a new routine.
    """
    if 'userID' not in routine or 'timeOfDay' not in routine or 'summary' not in routine:
        raise HTTPException(
            status_code = 400,
            detail = "Routine POST needs userID, timeOfDay, and summary."
        )
    userID, timeOfDay, summary = routine['userID'], routine['timeOfDay'], routine['summary']
    if timeOfDay not in ('day', 'night'):
        raise HTTPException(
            status_code = 400,
            detail = "Time of Day can only be 'day' or 'night'."
        )
    if len(summary) > 255:
        raise HTTPException(
            status_code = 400,
            detail = "Summary is limited to 255 characters in length."
        )
    stmt = select(user_table).where(user_table.c.userID == userID)
    result = db.execute(stmt).all()
    if not result:
        raise HTTPException(
            status_code = 400,
            detail = "UserID not found."
        )
    stmt = routine_table.insert().values(
        userID = userID,
        timeOfDay = timeOfDay,
        summary = summary
    )
    db.execute(stmt)
    db.commit()
    return {"message": "Routine created successfully"}

@router.put("/{routine_id}")
def update_product(routine_id: int, routine: dict, db: Engine = Depends(get_db)):
    """
    Update a routine.
    """
    if 'userID' not in routine or 'timeOfDay' not in routine or 'summary' not in routine:
        raise HTTPException(
            status_code = 400,
            detail = "Routine POST needs userID, timeOfDay, and summary."
        )
    userID, timeOfDay, summary = routine['userID'], routine['timeOfDay'], routine['summary']
    if timeOfDay not in ('day', 'night'):
        raise HTTPException(
            status_code = 400,
            detail = "Time of Day can only be 'day' or 'night'."
        )
    if len(summary) > 255:
        raise HTTPException(
            status_code = 400,
            detail = "Summary is limited to 255 characters in length."
        )
    stmt = select(user_table).where(user_table.c.userID == userID)
    result = db.execute(stmt).all()
    if not result:
        raise HTTPException(
            status_code = 400,
            detail = "UserID not found."
        )
    stmt = routine_table.update().values(
        userID = userID,
        timeOfDay = timeOfDay,
        summary = summary
    ).where(routine_table.c.routineID == routine_id)
    db.execute(stmt)
    db.commit()
    return {"message": "Routine updated successfully"}

@router.delete("/{routine_id}")
def get_product(routine_id: int, db: Engine = Depends(get_db)):
    """
    Delete a single routine by ID.
    """
    stmt = routine_table.delete().where(routine_table.c.routineID == routine_id)
    result = db.execute(stmt)
    db.commit()
    return result