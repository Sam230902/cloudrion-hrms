from app.database import db
from datetime import datetime

#mark
async def mark_attendance(data):
    existing = await db.attendance.find_one({
        "employee_id": data.employee_id,
        "date": str(data.date)
    })
    if existing:
        return {"error": "Attendance already marked"}

    attendance = {

        "employee_id": data.employee_id,
        "date": str(data.date),
        "check_in_time": data.check_in_time,
        "check_out_time": None,
        "check_hours": 0,
        "status": "Present",
        "late_flag": False,
        "early_exit_flag": False,
        "created_at": datetime.utcnow()
    }

    #late
    if data.check_in_time:
        check_in = datetime.strptime(
            data.check_in_time,
            "%H:%M"
        )

        office_time = datetime.strptime(
            "09:00",
            "%H:%M"
        )

        if check_in > office_time:

            attendance["late_flag"] = True
            attendance["status"] = "Late"

    
    result = await db.attendance.insert_one(attendance)

    return {
        "message": "Attendance Marked",
        "id": str(result.inserted_id)
    }


#checkout ,hours
async def checkout(
    employee_id: str,
    date: str,
    check_out_time: str
):

    record = await db.attendance.find_one({

        "employee_id": employee_id,
        "date": date
    })

    if not record:

        return {
            "error": "Attendance not found"
        }
    #already checkout
    if record.get("check_out_time"):
        return{
            "error":"Already checked out"
        }
    
    check_in = datetime.strptime(
        record["check_in_time"],
        "%H:%M"
    )

    check_out = datetime.strptime(
        check_out_time,
        "%H:%M"
    )

    total_hours = (
        check_out - check_in
    ).seconds / 3600

    office_end = datetime.strptime(
        "18:00",
        "%H:%M"
    )

    early_exit = check_out < office_end

    # UPDATE
    await db.attendance.update_one(

        {"_id": record["_id"]},

        {
            "$set": {

                "check_out_time":
                    check_out_time,

                "working_hours":
                    round(total_hours, 2),

                "early_exit_flag":
                    early_exit
            }
        }
    )

    return {

        "message": "Checkout Updated",
        "total_hours":round(total_hours, 2),
        "early_exit":early_exit
    }

#get all 
async def get_all_attendance():

    attendance_list = []

    async for item in db.attendance.find():

        item["id"] = str(item["_id"])

        attendance_list.append(item)

    return attendance_list