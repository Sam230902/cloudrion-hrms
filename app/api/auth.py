from fastapi import APIRouter,HTTPException
from app.database import db
from app.core.security import verify_password
from app.core.auth import create_token
from app.schemas.auth import LoginRequest

router=APIRouter(prefix="/auth")

@router.post("/login")
async def login(data: LoginRequest):
    user = await db.employees.find_one({"email": data.email})

    if not user or not verify_password(data.password, user["password_hash"]):
        raise HTTPException(status_code=401, detail="Invalid Credentials")

    token = create_token({
        "user_id": str(user["_id"]),
        "role": user["role"]
    })

    return {"access_token": token}