from fastapi import APIRouter
from app.database import db

router = APIRouter()

#super admin
@router.get("/super-admin")
async def super_admin_dashboard():
    total_employees = await db.employees.count_documents({})
    total_admins = await db.employees.count_documents({
        "role": "Admin"
    })
    total_hr = await db.employees.count_documents({
        "role": "HR Manager"
    })
    total_staff = await db.employees.count_documents({
        "role": "Employee"
    })
    active_employees = await db.employees.count_documents({
        "status": "Active"
    })
    leave_requests = await db.leave_requests.count_documents({
        "status": "Pending"
    })
    present_today = await db.attendance.count_documents({
        "status": "Present"
    })
    total_attendance = await db.attendance.count_documents({})
    attendance_percentage = 0
    if total_attendance > 0:
        attendance_percentage = round(
            (present_today / total_attendance) * 100
        )
    payroll_processed = await db.payroll.count_documents({
        "status": "Processed"
    })
    return {
        "total_employees": total_employees,
        "total_admins": total_admins,
        "total_hr": total_hr,
        "total_staff": total_staff,
        "active_employees": active_employees,
        "leave_requests": leave_requests,
        "attendance":f"{attendance_percentage}% Present",
        "payroll_processed":payroll_processed
    }