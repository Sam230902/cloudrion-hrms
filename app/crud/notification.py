from app.database import db
from datetime import datetime
from bson import ObjectId

#create

async def create_notification(data):
    doc=data.dict()
    doc["is_read"]=False
    doc["created_by"]=datetime.utcnow()
    result=await db.notifications.insert_one(doc)
    return doc

#get employee

async def get_notification(employee_id):
    result=[]
    async for doc in db.notifications.find({"employee_id":employee_id}):
        doc["id"]=str(doc["_id"])
        result.append(doc)
    return result

#mark read

async def mark_as_read(notification_id):
    await db.notifications.update_one(
        {"_id":ObjectId(notification_id)},
        {
            "$set":{
                "is_read":True
            }
        }
    )
    return {"message":"Marked as read"}