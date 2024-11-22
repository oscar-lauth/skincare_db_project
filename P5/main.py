from typing import Union
import sqlalchemy as db
from fastapi import FastAPI, HTTPException
from sqlalchemy import text

engine = db.create_engine("mssql+pyodbc://sa:DB_password_alex@localhost:1433/P3?driver=ODBC+Driver+17+for+SQL+Server", echo=True)
connection = engine.connect()
metadata = db.MetaData()
metadata.reflect(bind=connection)
product_table = db.Table('Product', metadata)

print(product_table.c.keys())

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "Word"}

@app.get("/items/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}

@app.get("/products")
def read_products():
    stmt = db.select(product_table)
    result = [row._mapping for row in connection.execute(stmt).all()]
    return result

@app.get("/products/{product_id}")
def read_product(product_id: int):
    stmt = db.select(product_table).where(product_table.c.productID == product_id)
    result = connection.execute(stmt).all()
    if len(result) == 0:
        raise HTTPException(status_code=404, detail="Item not found")
    return result[0]._mapping