import certifi
from motor.motor_asyncio import AsyncIOMotorClient

MONGO_URL = "mongodb+srv://smileysam038_db_user:Smileysam123@cluster0.luwxll.mongodb.net/"
client = AsyncIOMotorClient(
    MONGO_URL,
    tls=True,
    tlsCAFile=certifi.where(),
    serverSelectionTimeoutMS=30000
)

db = client["hrms"]