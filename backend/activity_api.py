
import os
import json
import uuid
from datetime import datetime
from typing import Any, Dict, List, Tuple

import boto3
from pymongo import MongoClient, DESCENDING

def get_db():
    """
    Dev-only: connect to DocumentDB/Mongo without TLS/CA.
    Env:
      DOCDB_URI  (e.g., mongodb://host:27017/?retryWrites=false)
      DOCDB_USER
      DOCDB_PASS
    """
    uri = os.environ.get('DOCDB_URI')
    username = os.environ.get('DOCDB_USER')
    password = os.environ.get('DOCDB_PASS')
    if not uri or not username or not password:
        raise Exception("Missing DocumentDB environment variables")
    client = MongoClient(
        uri,
        username=username,
        password=password,
        serverSelectionTimeoutMS=5000,
    )
    return client['moodmark']

def _resp(status: int, body_dict: Dict[str, Any]) -> Dict[str, Any]:
    return {
        "statusCode": status,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
        },
        "body": json.dumps(body_dict),
    }

def lambda_handler(event, context):
