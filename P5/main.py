from fastapi import FastAPI
import uvicorn
from queries import products, routines, conflicts, ingredients
app = FastAPI()

# Register the product router
app.include_router(products.router, prefix="/products", tags=["Products"])
app.include_router(routines.router, prefix="/routines", tags=["Routines"])
app.include_router(conflicts.router, prefix="/conflicts", tags=["Conflicts"])
app.include_router(ingredients.router, prefix="/ingredients", tags=["Ingredients"])

if __name__ == "__main__":
    uvicorn.run(
        "main:app",
        log_level="info",
        reload=True
    )
