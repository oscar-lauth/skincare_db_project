from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy import Table, select, and_, func
from sqlalchemy.engine import Engine
from database import get_db
from database import metadata

router = APIRouter()

favorites_table = Table('Favorites', metadata)
routine_table = Table('Routine', metadata)
users_table = Table('Users', metadata)

@router.get("/{user_id}")
def get_favorites(user_id: int, db: Engine = Depends(get_db)):
    """
    Get favorites by user ID
    """
    stmt = select(favorites_table.c.routineID).where(favorites_table.c.userID == user_id)
    result = db.execute(stmt).all()
    if not result:
        raise HTTPException(
            status_code=404,
            detail="This user has no favorites"
        )
    routine_ids = [row._mapping['routineID'] for row in result]
    return routine_ids

@router.post("/")
def create_favorite(favorite: dict, db: Engine = Depends(get_db)):
    """
    Insert a new favorite
    """
    if 'routineID' not in favorite or 'userID' not in favorite:
        raise HTTPException(
            status_code=400,
            detail="Needs routineID and userID"
        )
    stmt1 = select(routine_table).where(routine_table.c.routineID == favorite['routineID'])
    stmt2 = select(users_table).where(users_table.c.userID == favorite['userID'])
    result1 = db.execute(stmt1).all()
    result2 = db.execute(stmt2).all()
    if not result1:
        raise HTTPException(
            status_code=400,
            detail="RoutineID not found."
        )
    if not result2:
        raise HTTPException(
            status_code=400,
            detail="UserID not found."
        )
    stmt = favorites_table.insert().values(
        routineID=favorite['routineID'],
        userID=favorite['userID']
    )
    db.execute(stmt)
    db.commit()
    return {"message": "Favorite created successfully"}

@router.delete("/{routine_id}/{user_id}")
def delete_favorite(routine_id: int, user_id: int, db: Engine = Depends(get_db)):
    """
    Delete a favorite
    """
    stmt = favorites_table.delete().where(and_(favorites_table.c.routineID == routine_id, favorites_table.c.userID == user_id))
    result = db.execute(stmt)
    db.commit()
    if result.rowcount == 0:
        raise HTTPException(status_code=404, detail="Favorite not found")
    return {"message": "Favorite deleted successfully"}
