from fastapi import APIRouter, Depends
from app.schemas.attendance import AttendanceCreate
from app.crud.attendance import mark_attendance, checkout as checkout_attendance
from app.core.dependencies import require_role

router = APIRouter(prefix="/attendance", tags=["Attendance"])


# check-in
@router.post("/check-in")
async def check_in(
    data: AttendanceCreate,
    user=Depends(require_role(["Employee"]))  
):
    return await mark_attendance(data)


# check-out
@router.put("/checkout")
async def check_out(
    employee_id: str,
    date: str,
    check_out_time: str,
    user=Depends(require_role(["Employee"]))   
):
    return await checkout_attendance(employee_id, date, check_out_time)