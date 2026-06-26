from fastapi import APIRouter, Depends
from app.schemas.attendance import AttendanceCreate,CheckoutSchema
from app.crud.attendance import mark_attendance,checkout as checkout_attendance,get_all_attendance
from app.core.dependencies import require_role

router = APIRouter(prefix="/attendance",tags=["Attendance"])

#checkin
@router.post("/check-in")
async def attendance_check_in(
    data: AttendanceCreate,
    user=Depends(require_role(["Employee","HR Manager","Admin","Super Admin"]))):
    return await mark_attendance(data)

#checkout
@router.put("/check-out")
async def attendance_check_out(
    data: CheckoutSchema,
    user=Depends(require_role(["Employee","HR Manager","Admin","Super Admin"]))):
    return await checkout_attendance(
        data.employee_id,
        data.date,
        data.check_out_time
    )

#get all
@router.get("/")
async def attendance_get(user=Depends(require_role(["HR Manager","Admin","Super Admin"]))):
    return await get_all_attendance()