from app.database import db
from bson import ObjectId
from datetime import datetime

#create

async def create_balance(data):
    balance=data.dict()
    balance["employee_id"]=ObjectId(balance["employee_id"])
    balance["updated_at"]=datetime.utcnow()

    result=await db.leave_balances.insert_one(balance)
    return str(result.__inserted_id)

#get balance

async def get_balance(employee_id:str):
    balance=await db.leave_balances.find_one({
        "employee_id":ObjectId(employee_id)
    })
    if balance:
        balance["_id"]=str(balance["_id"])
    return balance

#update

async def update_balance(employee_id:str,data):
    await db.leave_balances.update_one(
        {"employee_id":ObjectId(employee_id)},
        {
            "$set":{
                **data.dict(exclude_none=True),
                "updated_at":datetime.utcnow()
            }
        }
    )
    return await get_balance(employee_id)

#default leave

async def deduct_leave(employee_id:str,leave_type:str,days:int):
    field_map={
        "CL":"cl_balance",
        "SL":"sl_balance",
        "EL":"el_balance"
    }
    field=field_map.get(leave_type)

    if not field:
        return {"error":"Invaild leave type"}
    balance=await db.leave_balances.find_one(
        {"employee_id":ObjectId(employee_id)},
        {
            "$inc":{field:-days},
            "$set":{"updated_at":datetime.utcnow()}
        }
    )
    return {"message":"Leave deducted"}