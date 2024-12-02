from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy import Table, select, and_
from sqlalchemy.engine import Engine
from database import get_db

router = APIRouter()

from database import metadata

conflicts_table = Table('ConflictsWith', metadata)
ingredient_table = Table('Ingredient', metadata)
includes_table = Table('Includes', metadata)

@router.get("/{ingredient_id_1}")
def get_conflicts(ingredient_id_1: int, db: Engine = Depends(get_db)):
    """
    Get conflicts by ingredient ID.
    """
    stmt = select(conflicts_table.c.ingredientID2).where(conflicts_table.c.ingredientID1 == ingredient_id_1)
    l = [conflict._mapping['ingredientID2'] for conflict in db.execute(stmt).all()]
    result = {'conflicts': l}
    return result

@router.post("/")
def create_conflict(conflict: dict, db: Engine = Depends(get_db)):
    """
    Insert a new conflict.
    """
    if 'ingredientID1' not in conflict or 'ingredientID2' not in conflict:
        raise HTTPException(
            status_code = 400,
            detail = "Needs ingredientID1 and ingredientID2"
        )
    ingredientID1, ingredientID2 = conflict['ingredientID1'], conflict['ingredientID2']
    stmt1 = select(ingredient_table).where(ingredient_table.c.ingredientID == ingredientID1)
    stmt2 = select(ingredient_table).where(ingredient_table.c.ingredientID == ingredientID2)
    result1 = db.execute(stmt1).all()
    result2 = db.execute(stmt2).all()
    if not result1 or not result2:
        raise HTTPException(
            status_code = 400,
            detail = "IngredientID not found."
        )
    stmt = conflicts_table.insert().values(
        ingredientID1 = ingredientID1,
        ingredientID2 = ingredientID2
    )
    db.execute(stmt)
    db.commit()
    return {"message": "Conflict created successfully"}

@router.delete("/{ingredient_id_1}/{ingredient_id_2}")
def get_product(ingredient_id_1: int, ingredient_id_2: int, db: Engine = Depends(get_db)):
    """
    Delete a conflict.
    """
    stmt = conflicts_table.delete().where(and_(conflicts_table.c.ingredientID1 == ingredient_id_1, conflicts_table.c.ingredientID2 == ingredient_id_2))
    result = db.execute(stmt)
    db.commit()
    return result

@router.get("/product/{product_id}")
def get_product_conflicts(product_id: int, db: Engine = Depends(get_db)):
    i2 = includes_table.alias('i2')
    stmt = select(includes_table.c.productID).select_from(
        includes_table.join(
            conflicts_table,
            conflicts_table.c.ingredientID1 == includes_table.c.ingredientID
        )
        .join(
            i2,
            conflicts_table.c.ingredientID2 == i2.c.ingredientID
        )
    ).where(i2.c.productID == product_id)
    result = [x._mapping['productID'] for x in db.execute(stmt).all()]
    if not result:
        raise HTTPException(
            status_code = 404,
            detail = "This product has no conflicts"
        )
    return result