from fastapi import APIRouter,Depends
from app.crud.leave_analytics import generate_leave_analytics
from app.core.dependencies import require_role

router=APIRouter(prefix="/leave-analytics",tags=["Leave Analytics"])

@router.post("/{employee_id}/{month}")
async def generate(employee_id:str,month:str,user=Depends(require_role(["Admin","Manager"]))):
    return await generate_leave_analytics(employee_id,month)