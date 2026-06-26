from fastapi import APIRouter,Depends
from app.schemas.leave import LeaveCreate,LeaveApprove
from app.crud.leave import apply_leave,get_my_leaves,update_leave
from app.core.dependencies import require_role

router=APIRouter(prefix="/leave",tags=["Leave"])

#employee apply leave

@router.post("/")
async def apply(data:LeaveCreate,user=Depends(require_role(["Employee","Manager"]))):
    return await apply_leave(data)

#employee own leaves

@router.get("/my/{employee_id}")
async def my_leaves(employee_id:str,user=Depends(require_role(["Employee","Manager"]))):
    return await get_my_leaves(employee_id)

#manager approve/reject

@router.put("/{leave_id}")
async def approve(leave_id:str,data:LeaveApprove,user=Depends(require_role(["Manager","Admin"]))):
    return await update_leave(leave_id,user["user_id"],data)