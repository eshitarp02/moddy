import requests
import pytest

API_URL = "https://tylp1a64mg.execute-api.eu-west-2.amazonaws.com/prod/activities"
TOKEN = "your_token"  # Replace with a valid token

@pytest.fixture
def get_headers():
    return {}

def test_get_activities_success(get_headers):
    headers = {"x-api-key": "EHsn17DBbq4QvO34nUzsf9pk1GNEcXLi6U9EdN84"}
    response = requests.get(API_URL, headers=headers)
    assert response.status_code == 200
    assert "items" in response.text or "logs" in response.text

def test_get_activities_empty(get_headers):
    headers = {"x-api-key": "EHsn17DBbq4QvO34nUzsf9pk1GNEcXLi6U9EdN84"}
    response = requests.get(f"{API_URL}?userId=empty-user", headers=headers)
    assert response.status_code == 200
    assert "items" in response.text or "logs" in response.text

def test_get_activities_filter_mood(get_headers):
    headers = {"x-api-key": "EHsn17DBbq4QvO34nUzsf9pk1GNEcXLi6U9EdN84"}
    response = requests.get(f"{API_URL}?mood=5", headers=headers)
    assert response.status_code == 200
    assert "items" in response.text or "logs" in response.text

def test_get_activities_filter_date(get_headers):
    headers = {"x-api-key": "EHsn17DBbq4QvO34nUzsf9pk1GNEcXLi6U9EdN84"}
    response = requests.get(f"{API_URL}?startDate=2025-08-01&endDate=2025-08-12", headers=headers)
    assert response.status_code == 200
    assert "items" in response.text or "logs" in response.text
