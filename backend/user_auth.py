import os
import json
import uuid
from passlib.hash import pbkdf2_sha256
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
        action = data.get('action')
        db = get_db()
        users = db['users']

        if action == 'register':
            name = data.get('name')
            email = data.get('email')
            password = data.get('password')
            provider = data.get('provider', 'email')
            providerId = data.get('providerId') if 'providerId' in data else None
            user = {
                "userId": str(uuid.uuid4()),
                "name": name,
                "email": email,
                "provider": provider
            }
            if provider == 'email':
                if password:
                    user["password"] = pbkdf2_sha256.hash(password)
            else:
                if providerId:
                    user["providerId"] = providerId
            users.insert_one(user)
            return {
                "statusCode": 201,
                "body": json.dumps({"message": "User registered", "userId": user["userId"]})
            }

        elif action == 'login':
            email = data.get('email')
            password = data.get('password')
            provider = data.get('provider', 'email')
            providerId = data.get('providerId') if 'providerId' in data else None
            if provider == 'email':
                user = users.find_one({"email": email, "provider": "email"})
                if user and password and pbkdf2_sha256.verify(password, user['password']):
                    return {
                        "statusCode": 200,
                        "body": json.dumps({"userId": user["userId"], "name": user["name"], "email": user["email"]})
                    }
                else:
                    return {"statusCode": 401, "body": json.dumps({"error": "Invalid credentials"})}
            else:
                query = {"provider": provider}
                if providerId:
                    query["providerId"] = providerId
                user = users.find_one(query)
                if user:
                    return {
                        "statusCode": 200,
                        "body": json.dumps({"userId": user["userId"], "name": user["name"], "email": user["email"]})
                    }
                else:
                    return {"statusCode": 401, "body": json.dumps({"error": "User not found"})}
        else:
            return {"statusCode": 400, "body": json.dumps({"error": "Invalid action"})}
    except Exception as e:
        return {"statusCode": 500, "body": json.dumps({"error": str(e)})}
