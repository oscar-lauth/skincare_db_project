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
