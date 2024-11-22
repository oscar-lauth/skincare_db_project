import sqlalchemy as db
from sqlalchemy.engine import Engine
import os
from dotenv import load_dotenv

load_dotenv()
DATABASE_URL = os.getenv("DB_URL")

# Replace with your connection string

engine = db.create_engine(DATABASE_URL)
connection = engine.connect()
metadata = db.MetaData()
metadata.reflect(bind=connection)

def get_db() -> Engine:
    """
    Dependency that provides a database connection.
    """
    return connection
