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

        # Load the rendered HTML template
        rendered_html = response.get_data(as_text=True)

        # Check specific content within the HTML
        self.assertIn("<!DOCTYPE html>", rendered_html)
        self.assertIn("<title>Welcome!</title>", rendered_html)
        # Add more assertions based on your template content

    def test_app_route(self):
        # Test the main route "/"
        response = self.app.get("/app")
        self.assertEqual(response.status_code, 200)

        # Load the rendered HTML template
        rendered_html = response.get_data(as_text=True)

        # Check specific content within the HTML
        self.assertIn("<!DOCTYPE html>", rendered_html)
        self.assertIn("<title>App!</title>", rendered_html)
        # Add more assertions based on your template content


if __name__ == "__main__":
    unittest.main()
