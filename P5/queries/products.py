from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy import Table, select
from sqlalchemy.engine import Engine
from database import get_db

router = APIRouter()

# Reflect the Product table from the database
from database import metadata

product_table = Table('Product', metadata)

@router.get("/")
def get_products(db: Engine = Depends(get_db)):
    """
    Get all products.
    """
    stmt = select(product_table)
    result = [row._mapping for row in db.execute(stmt).all()]
    return result

@router.get("/{product_id}")
def get_product(product_id: int, db: Engine = Depends(get_db)):
    """
    Get a single product by ID.
    """
    stmt = select(product_table).where(product_table.c.productID == product_id)
    result = db.execute(stmt).all()
    if not result:
        raise HTTPException(status_code=404, detail="Product not found")
    return result[0]._mapping

@router.post("/")
def create_product(product: dict, db: Engine = Depends(get_db)):
    """
    Insert a new product.
    """
    stmt = product_table.insert().values(
        productName=product["productName"],
        manufacturer=product["manufacturer"],
        productType=product["productType"],
        skinType=product["skinType"],
        price=product["price"],
    )
    db.execute(stmt)
    db.commit()
    return {"message": "Product created successfully"}
