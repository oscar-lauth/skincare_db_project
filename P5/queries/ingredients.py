from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy import Table, select
from sqlalchemy.engine import Engine
from database import get_db

router = APIRouter()

from database import metadata

ingredient_table = Table('Ingredient', metadata)
user_table = Table('Users', metadata)
includes_table = Table('Includes', metadata)

@router.get("/")
def get_ingredients(db: Engine = Depends(get_db)):
    """
    Get all ingredients.
    """
    stmt = select(ingredient_table)
    result = [row._mapping for row in db.execute(stmt).all()]
    return result

@router.get("/{ingredient_id}")
def get_product(ingredient_id: int, db: Engine = Depends(get_db)):
    """
    Get a single ingredient by ID.
    """
    stmt = select(ingredient_table).where(ingredient_table.c.ingredientID == ingredient_id)
    result = db.execute(stmt).first()
    if not result:
        raise HTTPException(status_code=404, detail="Ingredient not found")
    return result._mapping

@router.post("/")
def create_product(ingredient: dict, db: Engine = Depends(get_db)):
    """
    Insert a new ingredient.
    """
    if 'ingredientName' not in ingredient or 'ingredientUse' not in ingredient:
        raise HTTPException(
            status_code = 400,
            detail = "Ingredient ingredientName and ingredientUse"
        )
    ingredientName, ingredientUse = ingredient['ingredientName'], ingredient['ingredientUse']
    if len(ingredientName) > 30:
        raise HTTPException(
            status_code = 400,
            detail = "Ingredient name is limited to 30 characters in length."
        )
    if len(ingredientUse) > 100:
        raise HTTPException(
            status_code = 400,
            detail = "Ingredient use is limited to 100 characters in length."
        )
    stmt = ingredient_table.insert().values(
        ingredientName = ingredientName,
        ingredientUse = ingredientUse
    )
    db.execute(stmt)
    db.commit()
    return {"message": "Ingredient created successfully"}

@router.put("/{ingredient_id}")
def update_product(ingredient_id: int, ingredient: dict, db: Engine = Depends(get_db)):
    """
    Update a routine.
    """
    if 'ingredientName' not in ingredient or 'ingredientUse' not in ingredient:
        raise HTTPException(
            status_code = 400,
            detail = "Routine POST needs userID, timeOfDay, and summary."
        )
    ingredientName, ingredientUse = ingredient['ingredientName'], ingredient['ingredientUse']
    if len(ingredientName) > 30:
        raise HTTPException(
            status_code = 400,
            detail = "Ingredient name is limited to 30 characters in length."
        )
    if len(ingredientUse) > 100:
        raise HTTPException(
            status_code = 400,
            detail = "Ingredient use is limited to 100 characters in length."
        )
    stmt = ingredient_table.update().values(
        ingredientName = ingredientName,
        ingredientUse = ingredientUse
    ).where(ingredient_table.c.ingredientID == ingredient_id)
    db.execute(stmt)
    db.commit()
    return {"message": "Ingredient updated successfully"}

@router.delete("/{ingredient_id}")
def get_product(ingredient_id: int, db: Engine = Depends(get_db)):
    """
    Delete a single ingredient by ID.
    """
    stmt = ingredient_table.delete().where(ingredient_table.c.ingredientID == ingredient_id)
    result = db.execute(stmt)
    db.commit()
    return result

@router.get("/product/{product_id}")
def get_product(product_id: int, db: Engine = Depends(get_db)):
    """
    Delete all ingredients for a product by ID.
    """
    stmt = select(includes_table).where(includes_table.c.productID == product_id)
    result = [row._mapping['ingredientID'] for row in db.execute(stmt).all()]
    return result