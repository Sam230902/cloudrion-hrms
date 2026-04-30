from fastapi import Header, HTTPException, Depends
from jose import jwt
from typing import List
import os

SECRET_KEY = os.getenv("SECRET_KEY")
ALGORITHM = "HS256"


async def get_current_user(authorization: str = Header(...)):
    try:
        token = authorization.split(" ")[1]   
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload
    except:
        raise HTTPException(status_code=401, detail="Invalid token")


def require_role(roles: List[str]):   
    async def checker(user=Depends(get_current_user)):
        if user["role"] not in roles:
            raise HTTPException(status_code=403, detail="Access denied")
        return user

    return checker