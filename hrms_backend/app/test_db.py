import asyncio
from app.database import db

async def test():

    collections = await db.list_collection_names()

    print("Connected Successfully ✅")

    print(collections)

asyncio.run(test())