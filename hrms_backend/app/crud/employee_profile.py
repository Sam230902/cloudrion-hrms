from app.database import db
from bson import ObjectId
from datetime import datetime, date


def parse_date(date_str):
    if not date_str:
        return None

    try:
        return datetime.strptime(
            date_str,
            "%d-%m-%Y"
        )
    except:
        return datetime.strptime(
            date_str,
            "%Y-%m-%d"
        )


def calculate_age(dob):
    today = date.today()

    return (
        today.year
        - dob.year
        - (
            (today.month, today.day)
            < (dob.month, dob.day)
        )
    )

async def create_profile(data: dict):
    print(data)

    if data.get("date_of_birth"):
        dob = parse_date(data["date_of_birth"])
        data["date_of_birth"] = dob
        data["age"] = calculate_age(dob)

    if data.get("joining_date"):
        data["joining_date"] = parse_date(
            data["joining_date"]
        )

    if data.get("joining"):
        data["joining"] = parse_date(
            data["joining"]
        )

    if data.get("relieving_date"):
        data["relieving_date"] = parse_date(
            data["relieving_date"]
        )

    result = await db.employee_profiles.insert_one(data)

    profile = await db.employee_profiles.find_one(
        {"_id": result.inserted_id}
    )

    profile["id"] = str(profile["_id"])
    profile.pop("_id", None)

    return profile

async def get_profiles():

    profiles = []

    async for profile in db.employee_profiles.find():

        profile["id"] = str(profile["_id"])
        profile.pop("_id", None)

        profiles.append(profile)

    return profiles

async def get_profile(employee_id: str):

    profile = await db.employee_profiles.find_one(
        {
            "$or": [
                {
                    "employee_id": employee_id
                },
                {
                    "employee_code": employee_id
                }
            ]
        }
    )

    if profile:

        profile["id"] = str(profile["_id"])
        profile.pop("_id", None)

    return profile

async def update_profile(id: str, data: dict):

    if data.get("date_of_birth"):
        dob = parse_date(data["date_of_birth"])
        data["date_of_birth"] = dob
        data["age"] = calculate_age(dob)

    if data.get("joining_date"):
        data["joining_date"] = parse_date(
            data["joining_date"]
        )

    if data.get("joining"):
        data["joining"] = parse_date(
            data["joining"]
        )

    if data.get("relieving_date"):
        data["relieving_date"] = parse_date(
            data["relieving_date"]
        )

    await db.employee_profiles.update_one(
        {"_id": ObjectId(id)},
        {"$set": data}
    )

    profile = await db.employee_profiles.find_one(
        {"_id": ObjectId(id)}
    )

    profile["id"] = str(profile["_id"])
    profile.pop("_id", None)

    return profile

async def delete_profile(id: str):

    await db.employee_profiles.delete_one(
        {
            "_id": ObjectId(id)
        }
    )

    return {
        "message":
        "Deleted Successfully"
    }