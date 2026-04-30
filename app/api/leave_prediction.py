from fastapi import APIRouter,Depends
from app.crud.leave_prediction import generate_prediction
from app.core.dependencies import require_role

router=APIRouter(prefix="/leave-prediction",tags=["AI Leave Prediction"])

@router.get("/{employee_id}")
async def predict(employee_id:str,user=Depends(require_role(["Admin","Manager"]))):
    return await generate_prediction(employee_id)