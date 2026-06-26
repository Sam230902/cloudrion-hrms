from datetime import datetime
from app.schemas.employee_profile import EmployeeProfile


# -----------------------------
# Helper: Date Parser
# -----------------------------
def parse_date(date_str):
    if not date_str:
        return None

    return datetime.strptime(date_str, "%d-%m-%Y").date()


# -----------------------------
# Create Employee Profile
# -----------------------------
async def create_profile(payload, db):
    try:
        new_profile = EmployeeProfile(
            employee_id=payload.employee_id,
            employee_code=payload.employee_code,

            first_name=payload.first_name,
            middle_name=payload.middle_name,
            last_name=payload.last_name,

            email=payload.email,
            phone=payload.phone,

            gender=payload.gender,
            blood_group=payload.blood_group,

            dob=parse_date(payload.dob),  # using your helper

            marital_status=payload.marital_status,
            nationality=payload.nationality,
            religion=payload.religion,

            address=payload.address,
            pincode=payload.pincode,

            pan_number=payload.pan_number,
            passport_number=payload.passport_number,

            height=payload.height,
            weight=payload.weight,

            profile_photo=payload.profile_photo,

            created_at=datetime.utcnow()
        )

        db.add(new_profile)
        await db.commit()
        await db.refresh(new_profile)

        return new_profile

    except Exception as e:
        await db.rollback()
        raise Exception(f"Error creating employee profile: {str(e)}")