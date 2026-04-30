from app.database import db
from datetime import datetime

async def create_holiday(data):
    doc=data.dict()
    doc["created_by"]=datetime.utcnow()
    result=await db.holidays.insert_one(doc)
    doc["id"]=str(result.inserted_id)
    return doc

async def get_holidays():
    result=[]
    async for doc in db.holidays.find():
        doc["id"]=str(doc["_id"])
        result.append(doc)
    return result