from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy import Table, select, join, and_
from sqlalchemy.engine import Engine
from database import get_db
from pydantic import BaseModel
from enum import Enum

class ProductTypeEnum(str, Enum):
    cleanser = 'Cleanser'
    moisturizer = 'Moisturizer'
    sunscreen = 'Sunscreen'
    acne_treatment = 'Acne Treatment'
    serum = 'Serum'
    eye_cream = 'Eye Cream'
    mask = 'Mask'
    toner='Toner'
    exfoliant='Exfoliant'
class SkinTypeEnum(str, Enum):
    normal = 'normal'
    oily = 'oily'
    dry = 'dry'
    combination = 'combination'
    sensitive = 'sensitive'
class ProductModel(BaseModel):
    productName: str
    manufacturer: str
    productType: ProductTypeEnum
    skinType: SkinTypeEnum = SkinTypeEnum.normal
    price: float

router = APIRouter()

# Reflect the Product table from the database
from database import metadata

product_table = Table('Product', metadata)
sunscreen_table = Table('Sunscreen', metadata)
moisturizer_table = Table('Moisturizer', metadata)
cleanser_table = Table('Cleanser', metadata)


@router.get("/")
def get_products(skinType: SkinTypeEnum | None = None, productType: ProductTypeEnum | None = None, db: Engine = Depends(get_db)):
    """
    Get all products.
    """
    stmt = select(product_table)
    conditions = []
    if skinType:
        conditions.append(product_table.c.skinType == skinType)
    if productType:
        conditions.append(product_table.c.productType == productType)
    if conditions:
        stmt = stmt.where(and_(*conditions))
    result = [row._mapping for row in db.execute(stmt).all()]
    return result

@router.get("/sunscreens/")
def get_sunscreens(db: Engine = Depends(get_db)):
    """
    Get all sunscreen products.
    """
    stmt = select(join(sunscreen_table,product_table,onclause=sunscreen_table.c.productID==product_table.c.productID))
    result = [row._mapping for row in db.execute(stmt).all()]
    return result

@router.get("/moisturizers/")
def get_moisturizers(db: Engine = Depends(get_db)):
    """
    Get all moisturizer products.
    """
    stmt = select(join(moisturizer_table,product_table,onclause=moisturizer_table.c.productID==product_table.c.productID))
    result = [row._mapping for row in db.execute(stmt).all()]
    return result

@router.get("/cleansers/")
def get_cleansers(db: Engine = Depends(get_db)):
    """
    Get all cleanser products.
    """
    stmt = select(join(cleanser_table,product_table,onclause=cleanser_table.c.productID==product_table.c.productID))
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
def create_product(product: ProductModel, db: Engine = Depends(get_db)):
    """
    Insert a new product.
    """
    stmt = product_table.insert().values(
        productName=product.productName,
        manufacturer=product.manufacturer,
        productType=product.productType,
        skinType=product.skinType,
        price=product.price,
    )
    db.execute(stmt)
    db.commit()
    return {"message": "Product created successfully"}

@router.delete("/{product_id}")
def delete_product(product_id: int, db: Engine = Depends(get_db)):
    """
    Delete a single product by ID.
    """
    stmt = product_table.delete().where(product_table.c.productID == product_id)
    result = db.execute(stmt)
    db.commit()
    return result