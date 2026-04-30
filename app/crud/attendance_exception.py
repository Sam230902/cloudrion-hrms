from app.database import db
from datetime import datetime
from bson import ObjectId

#create request
async def create_exception(data):
    doc=data.dict()
    doc["status"]="Pending"
    doc["request_at"]=datetime.utcnow()
    result=await db.exceptions.insert_one(doc)
    doc["id"]=str(result.inserted_id)
    return doc

#get all
async def get_exception():
    result=[]
    async for doc in db.exceptions.find():
        doc["id"]=str(doc["_id"])
    return result

#approve/reject

async def update_exception(exception_id,manager_id,status):
    exception=await db.exceptions.find_one({"_id":ObjectId(exception_id)})
    if not exception:
        return{"error":"Exception not found"}
    #if approve update

    if status=="Approved":
        await db.attendance.update_one(
            {"_id":ObjectId(exception["attendance_id"])},
            {"$set":exception["requested_changes"]}
        )

    #update
    await db.exception.update_one(
        {"_id":ObjectId(exception_id)},
        {"$set":{
            "status":status,
            "approved_by":manager_id,
            "approved_by":datetime.utcnow()
        }}
    )
    return {"message":f"Excepion{status}"}

