from app.database import db
from datetime import datetime

async def create_location(data):
    doc=data.dict()
    doc["created_at"]=datetime.utcnow()
    result=await db.work_location.insert_one(doc)
    doc["id"]=str(result.inserted_id)
    return doc

async def get_locations(employee_id):
    result=[]
    async for doc in db.work_locations.find({"employee_id":employee_id}):
        doc["id"]=str(doc["id"])
        result.append(doc)
    return result