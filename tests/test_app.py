import unittest
from app import app


class FlaskAppTestCase(unittest.TestCase):
    def setUp(self):
        # Create a test client
        self.app = app.test_client()
        self.app.testing = True

    def test_main_route(self):
        # Test the main route "/"
        response = self.app.get("/")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data.decode("utf-8"), "Welcome!")

    def test_hello_route(self):
        # Test the "/app" route
        response = self.app.get("/app")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data.decode("utf-8"), "This is the App Section!!")


if __name__ == "__main__":
    unittest.main()
