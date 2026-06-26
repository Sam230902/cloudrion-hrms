from app.database import db
from datetime import datetime
from bson import ObjectId

#apply leave

async def apply_leave(data):
    leave=data.dict()
    leave["employee_id"]=ObjectId(leave["employee_id"])
    leave["start_date"]=datetime.combine(data.start_date,datetime.min.time())
    leave["end_date"]=datetime.combine(data.end_date,datetime.min.time())

    #calculate total days

    leave["total_days"]=(data.end_date - data.start_date).days +1
    leave ["status"]="Pending"
    leave["applied_at"]=datetime.utcnow()
    leave["approved_by"]=None
    leave["approved_at"]=None
    leave["comments"]=None

    result=await db.leave_requests.insert_one(leave)
    return str(result.inserted_id)
    
#get my leave

async def get_my_leaves(employee_id:str):
    leaves=[]
    async for leave in db.leave_requests.find({"employee_id":ObjectId(employee_id)}):
        leave["_id"]=str(leave["_id"])
        leave.append(leave)
    return leaves

#approve/reject

async def update_leave(leave_id:str,manager_id:str,data):
    await db.leave_requests.update_one(
        {"_id":ObjectId(leave_id)},
        {
            "$set":{
                "status": data.status,
                "approved_by":ObjectId(manager_id),
                "approved_at":datetime.utcnow(),
                "comments":data.comments

            }
        }
    )
    return {"message":"Leave updated"}

    
