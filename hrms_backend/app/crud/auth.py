from fastapi import HTTPException
from app.database import db
from app.core.security import verify_password,create_access_token

async def login_user(data):
    user = await db.employees.find_one({
        "email": data.email
    })

    if not user:
        raise HTTPException(
            status_code=401,
            detail="Invalid email"
        )

    valid = verify_password(
        data.password,
        user["password"]
    )

    if not valid:
        raise HTTPException(
            status_code=401,
            detail="Invalid password"
        )

    token = create_access_token({

        "id": str(user["_id"]),
        "email": user["email"],
        "role": user["role"],
    })

    return {

        "access_token": token,
        "role": user["role"],
    }