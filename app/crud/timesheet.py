from app.database import db
from datetime import datetime
from bson import ObjectId

#create timesheet

async def create_timesheet(data):
    doc=data.dict()
    doc["status"]="Submitted"
    doc["created_at"]=datetime.utcnow()
    result=await db.timesheets.insert_one(doc)
    doc["id"]=str(result.inserted_id)
    return doc

#get employee

async def get_my_timesheets(employee_id):
    result=[]
    async for doc in db.timesheets.find({"employee_id":employee_id}):
        doc["id"]=str(doc["_id"])
        result.append(doc)
    return result

#get all manager

async def get_all_timesheets():
    result=[]
    async for doc in db.timesheets.find():
        doc["id"]=str(doc["_id"])
        result.append(doc)
    return result

#approve

async def approve_timesheet(timesheet_id,status):
    await db.timesheets.update_one(
        {"_id":ObjectId(timesheet_id)},
        {"$set":{
            "status":status
        }}
    )
    return {"message":f"Timesheet{status}"}