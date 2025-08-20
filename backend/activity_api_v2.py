import os
import json
import uuid
import hashlib
from datetime import datetime, timezone, timedelta
from typing import Any, Dict, List, Tuple, Optional

import boto3
from pymongo import MongoClient, DESCENDING

# -----------------------------
# DB (DocDB requires TLS; dev-safe: skip CA verification)
# -----------------------------
def get_db():
    """
    Env:
      DOCDB_URI  (e.g., mongodb://host:27017/?replicaSet=rs0&readPreference=secondaryPreferred&retryWrites=false)
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
        tls=True,                         # DocDB needs TLS
        tlsAllowInvalidCertificates=True, # DEV ONLY (do NOT use in prod)
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


# -----------------------------
# Bedrock + HTTP helpers
# -----------------------------
# Prefer a custom override; otherwise use Lambda-provided region.
BEDROCK_REGION = (
    os.getenv("BEDROCK_REGION")
    or os.getenv("AWS_REGION")
    or os.getenv("AWS_DEFAULT_REGION")
    or "eu-west-2"
)
# Default to smarter, warmer Sonnet; still overridable via env
MODEL_ID = os.getenv("MODEL_ID", "anthropic.claude-3-5-sonnet-20240620")
bedrock = boto3.client("bedrock-runtime", region_name=BEDROCK_REGION)

# ...existing code...
# (The rest of the code is as provided in your request)
