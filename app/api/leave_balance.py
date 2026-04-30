from fastapi import APIRouter,Depends
from app.schemas.leave_balance import LeaveBalanceCreate,LeaveBalanceUpdate
from app.crud.leave_balance import create_balance,get_balance,update_balance
from app.core.dependencies import require_role

router=APIRouter(prefix="/leave-balance",tags=["Leave Balance"])

#create

@router.post("/")
async def create(data:LeaveBalanceCreate,user=Depends(require_role(["Admin"]))):
    return await create_balance(data)

#all users

@router.get("/{employee_id}")
async def read(employee_id:str,user=Depends(require_role(["Admin","Manager","Employee"]))):
    return await get_balance(employee_id)

#update

@router.put("/{employee_id}")
async def update(employee_id:str,data:LeaveBalanceUpdate,user=Depends(require_role(["Admin"]))):
    return await update_balance(employee_id,data)