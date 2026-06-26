from fastapi import APIRouter,Depends
from app.schemas.attendance_exception import ExceptionCreate,ExceptionApprove
from app.crud.attendance_exception import create_exception,get_exception,update_exception
from app.core.dependencies import require_role

router=APIRouter(prefix="/exceptions",tags=["Exception Management"])

#employee create

@router.post("/")
async def create(data:ExceptionCreate,user=Depends(require_role(["Employee"]))):
    return await create_exception(data)

#manager/admin

@router.get("/")
async def list_all(user=Depends(require_role(["Manager","Admin"]))):
    return await get_exception()

#approve/reject

@router.put("/{exception_id}")
async def approve(exception_id:str,data:ExceptionApprove,user=Depends(require_role(["Manager","Admin"]))):
    return await update_exception(exception_id,user["user_id"],data.status)