from fastapi import FastAPI
import uvicorn
from queries import products
app = FastAPI()

# Register the product router
app.include_router(products.router, prefix="/products", tags=["Products"])

@app.get("/")
def read_root():
    return {"Hello": "World"}

if __name__ == "__main__":
    uvicorn.run(
        "main:app",
        log_level="info",
        reload=True
    )
