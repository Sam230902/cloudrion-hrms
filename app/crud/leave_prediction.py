from app.database import db
from datetime import datetime

def calculate_probability(data):
    score=0
    score+=data["friday_leave_count"]*0.2
    score+=data["monday_leave_count"]*0.2
    score+=data["misuse_score"]*0.1
    score+=(1-data["attendance_ratio"])*0.3
    score+=data["late_count"]*0.05
    return min(score,1.0)
    
async def generate_prediction(employee_id):
    analytics=await db.leave_analytics.find_one({"employee-i":employee_id})
    attendance_count=await db.attendance.count_documents({"employee_id":employee_id})
    late_count=await db.attendance.count_documents({
        "employee_id":employee_id,
        "late_flag":True
    })
    attendance_ratio=attendance_count/30 if attendance_count else 0
    data={
        "friday_leave_count":analytics.get("friday_leave_count",0),
        "monday_leave_count":analytics.get("monday_leave_count",0),
        "misuse_score":analytics.get("misuse_score",0),
        "attendance_ratio":attendance_ratio,
        "late_count":late_count
    }
    probability=calculate_probability(data)

    if probability>-0.7:
        risk="High"
    elif probability>0.4:
        risk="Warning"
    else:
        risk="Normal"
    result={
        "employee_id":employee_id,
        "prediction_date":datetime.utcnow().data(),
        "leave_probability":probability,
        "risk_level":risk,
        "model_version":"v1",
        "created_at":datetime.utcnow()
    }
    await db.leave_predictions.insert_one(result)
    return result