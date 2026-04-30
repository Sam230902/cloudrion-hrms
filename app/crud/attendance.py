from app.database import db
from datetime import datetime

async def mark_attendance(data):
    attendance={
        "employee_id":data.employee_id,
        "date":str(data.date),
        "check_in_time":data.check_in_time,
        "check_out_time":data.check_out_time,
        "check_hours":None,
        "status":"Present",
        "late_flag":False,
        "early_exit_flag":False,
        "created_at":datetime.utcnow()
    }

    #late check

    if data.check_in_time and data.check_in_time>"09:00":
        attendance["late_flag"]=True
        attendance["status"]="Late"
    result=await db.attendance.insert_one(attendance)
    return{"message":"Attendance Marked","id":str(result.inserted_id)}

#update checkout & Calculate hours

async def checkout(employee_id:str,date:str,check_out_time:str):
    record=await db.attendance.find_one({
        "employee_id":employee_id,
        "date":date
    })
    if not record:
        return {"error":"Attendance not found"}
    
    #calculate hours
    check_in=datetime.strptime(record["check_in_time"],"%H:%M")
    check_out=datetime.strptime(check_out_time,"%H:%M")
    total_hours=(check_out-check_in).seconds/3600
    early_exit=check_out_time<"18:00"
    await db.attendance.update_one(
        {"_id":record["_id"]},
        {
            "$set":{
                "check_out_time":check_out_time,
                "total_hours":total_hours,
                "early_exit_flag":early_exit
            }
        }
    )
    return{"message":"Checkout updated","total_hours":total_hours}