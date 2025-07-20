import os
import json
import boto3
import logging
import requests
from datetime import datetime, timedelta
from botocore.exceptions import ClientError

def get_recent_activities(user_id, s3, bucket, max_logs=10):
    prefix = f"{user_id}/"
    try:
        response = s3.list_objects_v2(Bucket=bucket, Prefix=prefix)
        if 'Contents' not in response:
            return []
        # Sort by LastModified descending, get latest max_logs
        files = sorted(response['Contents'], key=lambda x: x['LastModified'], reverse=True)[:max_logs]
        activities = []
        for obj in files:
            file_obj = s3.get_object(Bucket=bucket, Key=obj['Key'])
            content = file_obj['Body'].read().decode('utf-8')
            activities.append(json.loads(content))
        return activities
    except Exception as e:
        logging.exception("Error fetching activities from S3")
        return []

def call_google_ai(prompt, api_key):
    # Example endpoint, replace with actual Google AI Studio endpoint
    url = os.environ.get('GOOGLE_AI_API_URL', 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent')
    headers = {
        'Content-Type': 'application/json',
        'Authorization': f'Bearer {api_key}'
    }
    data = {
        "contents": [{"parts": [{"text": prompt}]}]
    }
    response = requests.post(url, headers=headers, json=data, timeout=10)
    response.raise_for_status()
    result = response.json()
    # Parse suggestion from result (adjust as per actual API response)
    suggestion = result.get('candidates', [{}])[0].get('content', {}).get('parts', [{}])[0].get('text', 'Try something new!')
    return suggestion

def lambda_handler(event, context):
    logger = logging.getLogger()
    logger.setLevel(logging.INFO)
    s3 = boto3.client('s3')
    BUCKET_NAME = os.environ.get('S3_BUCKET', 'moodmark-user-logs')
    GOOGLE_AI_API_KEY = os.environ.get('GOOGLE_AI_API_KEY')
    try:
        params = event.get('queryStringParameters') or {}
        user_id = params.get('user_id')
        if not user_id:
            return {"statusCode": 400, "body": json.dumps({"error": "Missing user_id"})}
        safe_user_id = "".join(c for c in user_id if c.isalnum() or c in ('-', '_'))
        activities = get_recent_activities(safe_user_id, s3, BUCKET_NAME)
        if not activities:
            return {"statusCode": 200, "body": json.dumps({"suggestion": "Log some activities first!"})}
        # Compile prompt
        prompt = "Here are my recent hobby activities: "
        for act in activities:
            prompt += f"\n- {act['activity_type']}: {act['title']} ({act.get('description','')})"
        prompt += "\nWhat fun hobby should I try next?"
        suggestion = call_google_ai(prompt, GOOGLE_AI_API_KEY)
        return {"statusCode": 200, "body": json.dumps({"suggestion": suggestion})}
    except requests.RequestException:
        logger.exception("Google AI API error.")
        return {"statusCode": 502, "body": json.dumps({"error": "AI suggestion service unavailable."})}
    except Exception:
        logger.exception("Unexpected error.")
        return {"statusCode": 500, "body": json.dumps({"error": "Internal server error."})}
