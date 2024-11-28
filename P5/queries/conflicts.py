from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy import Table, select
from sqlalchemy.engine import Engine
from database import get_db

router = APIRouter()

from database import metadata

conflicts_table = Table('ConflictsWith', metadata)

@router.get("/{product_id}")
def get_conflicts(product_id: int, db: Engine = Depends(get_db)):
    """
    Get conflicts by product ID.
    """
    stmt = select(conflicts_table.c.ingredientID2).where(conflicts_table.c.ingredientID1 == product_id)
    l = [conflict._mapping['ingredientID2'] for conflict in db.execute(stmt).all()]
    result = {'conflicts': l}
    return result