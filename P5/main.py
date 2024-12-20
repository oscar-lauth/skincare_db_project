from fastapi import FastAPI
import uvicorn
from queries import products, routines, conflicts, ingredients, reviews, favorites, users
app = FastAPI()

app.include_router(products.router, prefix="/products", tags=["Products"])
app.include_router(routines.router, prefix="/routines", tags=["Routines"])
app.include_router(conflicts.router, prefix="/conflicts", tags=["Conflicts"])
app.include_router(ingredients.router, prefix="/ingredients", tags=["Ingredients"])
app.include_router(reviews.router, prefix="/reviews", tags=["Reviews"])
app.include_router(favorites.router, prefix="/favorites", tags=["Favorites"])
app.include_router(users.router, prefix="/users", tags=["Users"])

if __name__ == "__main__":
    uvicorn.run(
        "main:app",
        log_level="info",
        reload=True
    )
