from pydantic import BaseModel,EmailStr
from typing import Optional



class EmployeeProfile(BaseModel):
    employee_id:str
    employee_code:str
    first_name:str
    middle_name:Optional[str]=None
    last_name:str
    email:EmailStr
    phone:str
    password:str
    role:str
    manager_id:Optional[str]=None
    department:str
    designation:str
    joining_date:str
    status:Optional[str]=None
    profile_image:Optional[str]=None

    #personal
    date_of_birth:str
    age: Optional[int] = None
    blood_group:str
    gender:str
    marital_status:str
    religion:str
    nationality:str
    native_state:str
    district:str

    #identity
    pan_number:str
    passport_number:Optional[str]=None

    #physical
    height:float
    weight:float

    #address
    permanent_address:str
    pincode:str

    #family
    father_name:str
    mother_name:str
    spouse_name:Optional[str]=None
    children_count:Optional[int]=0
    emergency_contact_name:str
    emergency_contact_number:str
    relationship:str
    occupation:Optional[str]=None

    tenth_school_name:str
    tenth_board:str
    tenth_percentage:float
    tenth_passed_out_year:int

    twelfth_school_name:str
    twelfth_board:str
    twelfth_percentage:float
    twelfth_passed_out_year:int

    diploma_course_name:Optional[str]=None
    diploma_college_name: Optional[str] = None
    diploma_university: Optional[str] = None
    diploma_percentage: Optional[float] = None
    diploma_passed_out_year: Optional[int] = None

    ug_degree_name: str
    ug_department: str
    ug_college_name: str
    ug_university_name: str
    ug_percentage: float
    ug_passed_out_year: int

    pg_degree_name: Optional[str] = None
    pg_specialization: Optional[str] = None
    pg_college_name: Optional[str] = None
    pg_university_name: Optional[str] = None
    pg_percentage: Optional[float] = None
    pg_passed_out_year: Optional[int] = None

    #extra
    certifications: Optional[str] = None
    skills: Optional[str] = None
    training_details: Optional[str] = None
    internship_details: Optional[str] = None
    project_details: Optional[str] = None

    company_name: str
    employment_designation: str
    employment_department: str
    employment_type: str
    work_location: str

    joining:str
    relieving_date: Optional[str] = None
    current_company: bool
    notice_period: Optional[str] = None

    previous_ctc: Optional[float] = 0
    current_ctc: Optional[float] = 0
    expected_ctc: Optional[float] = 0

    project_name: Optional[str] = None
    client_name: Optional[str] = None
    project_duration: Optional[str] = None
    role_in_project: Optional[str] = None
    technologies_used: Optional[str] = None
    project_description: Optional[str] = None


