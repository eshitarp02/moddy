import pytest
from unittest.mock import patch, MagicMock
from backend import activity_api

def test_post_activity_valid(monkeypatch):
    monkeypatch.setenv("LOG_LEVEL", "INFO")
    event = {"body": '{"userId": "u1", "activity": "walk"}'}
    context = None
    with patch("backend.activity_api.some_db_client") as mock_db:
        mock_db.return_value.insert_one.return_value = MagicMock(inserted_id="id123")
        result = activity_api.lambda_handler(event, context)
        assert result["statusCode"] == 200
        assert "success" in result["body"]

def test_post_activity_missing_fields():
    event = {"body": '{"activity": "walk"}'}
    context = None
    result = activity_api.lambda_handler(event, context)
    assert result["statusCode"] == 400
    assert "Missing required fields" in result["body"]

def test_post_activity_db_error(monkeypatch):
    event = {"body": '{"userId": "u1", "activity": "walk"}'}
    context = None
    with patch("backend.activity_api.some_db_client") as mock_db:
        mock_db.return_value.insert_one.side_effect = Exception("DB error")
        result = activity_api.lambda_handler(event, context)
        assert result["statusCode"] == 500
        assert "DB error" in result["body"]
