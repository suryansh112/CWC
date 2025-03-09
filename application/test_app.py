import pytest
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_home(client):
    """Test the index page loads correctly"""
    rv = client.get('/app')
    assert rv.status_code == 200
    assert b"Enter Your Name" in rv.data


def test_submit_success(client):
    """Test form submission with a valid name"""
    rv = client.post('/submit', data={'name': 'John'})
    assert rv.status_code == 200
    assert b"Hello, John!" in rv.data

def test_submit_empty(client):
    """Test form submission with an empty name"""
    rv = client.post('/submit', data={'name': ''})
    assert rv.status_code == 200
    assert b"Name cannot be empty" in rv.data
