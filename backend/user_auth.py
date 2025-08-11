import os
import json
import uuid
import bcrypt
from pymongo import MongoClient
from botocore.exceptions import ClientError

def get_db():
    uri = os.environ.get('DOCDB_URI')
    username = os.environ.get('DOCDB_USER')
    password = os.environ.get('DOCDB_PASS')
    if not uri or not username or not password:
        raise Exception("Missing DocumentDB environment variables")
    client = MongoClient(
        uri,
        username=username,
        password=password,
        tls=True,
        tlsAllowInvalidCertificates=True,
        serverSelectionTimeoutMS=5000  # 5 seconds timeout
    )
    return client['moodmark']

def lambda_handler(event, context):
    try:
        body = event.get('body')
        if isinstance(body, str):
            data = json.loads(body)
        else:
            data = body
        db = get_db()
        users = db['users']

        # Registration logic remains unchanged
        if data.get('action') == 'register':
            name = data['name']
            email = data['email'].strip().lower()
            password = data.get('password')
            provider = data.get('provider', 'email')
            providerId = data.get('providerId')
            existing = users.find_one({"email": email, "provider": provider})
            if existing:
                return {
                    "statusCode": 409,
                    "body": json.dumps({"error": "User with this email already exists"})
                }
            if provider == 'email':
                hashed = bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()
                user = {
                    "userId": str(uuid.uuid4()),
                    "name": name,
                    "email": email,
                    "password": hashed,
                    "provider": provider
                }
            else:
                user = {
                    "userId": str(uuid.uuid4()),
                    "name": name,
                    "email": email,
                    "provider": provider,
                    "providerId": providerId
                }
            users.insert_one(user)
            return {
                "statusCode": 201,
                "body": json.dumps({"message": "User registered", "userId": user["userId"]})
            }

        # Login logic: accept single 'username' field and 'password'
        if data.get('username') and data.get('password'):
            username = data['username'].strip()
            password = data['password']
            import re
            email_regex = r"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"
            user = None
            if '@' in username and re.match(email_regex, username, re.IGNORECASE):
                # Case-insensitive email lookup
                user = users.find_one({"email": username.lower()})
            else:
                # Case-insensitive name lookup
                user = users.find_one({"name": re.compile(f"^{re.escape(username)}$", re.IGNORECASE)})
            if not user:
                return {
                    "statusCode": 404,
                    "body": json.dumps({"error": "User not registered, please register."})
                }
            if not bcrypt.checkpw(password.encode(), user['password'].encode()):
                return {
                    "statusCode": 401,
                    "body": json.dumps({"error": "Incorrect password."})
                }
            return {
                "statusCode": 200,
                "body": json.dumps({"userId": user["userId"]})
            }

        return {"statusCode": 400, "body": json.dumps({"error": "Invalid request. Please provide username and password."})}
    except Exception as e:
        return {"statusCode": 500, "body": json.dumps({"error": str(e)})}
