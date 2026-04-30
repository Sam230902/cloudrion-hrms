from fastapi import APIRouter,Depends
from app.schemas.timesheet import TimesheetCreate,TimesheetApprove
from app.crud.timesheet import create_timesheet,get_my_timesheets,get_all_timesheets,approve_timesheet
from app.core.dependencies import require_role

router=APIRouter(prefix="/timesheets",tags=["Timesheet"])

#create

@router.post("/")
async def create(data:TimesheetCreate,user=Depends(require_role(["Employee"]))):
    return await create_timesheet(data)

#my timesheet

@router.get("/my/{employee_id}")
async def my_timesheets(employee_id:str,user=Depends(require_role(["Employee"]))):
    return await get_my_timesheets(employee_id)

#manager view

@router.get("/")
async def all_timeshetts(user=Depends(require_role(["Manager","Admin"]))):
    return await get_all_timesheets()

#approve
@router.put("/{timesheet_id}")
async def approve(timesheet_id:str,data:TimesheetApprove,user=Depends(require_role(["Manager","Admin"]))):
    return await approve_timesheet(timesheet_id,data.status)