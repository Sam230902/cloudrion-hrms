from jose import jwt
from datetime import datetime, timedelta

SECRET_KEY = "hrms_secret_key"

ALGORITHM = "HS256"


def create_token(data: dict):

    payload = data.copy()

    payload["exp"] = datetime.utcnow() + timedelta(hours=1)

    token = jwt.encode(
        payload,
        SECRET_KEY,
        algorithm=ALGORITHM
    )

    return token