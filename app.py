from settings import app_info
from flask import Flask, render_template


app = Flask(__name__)


@app.route("/")
def main():
    return render_template("index.html")


@app.route("/app")
def hello():
    return render_template("app.html")


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(app_info().get("APP_PORT", 5000)))
