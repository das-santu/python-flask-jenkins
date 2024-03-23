from os import environ
from settings import app_info
from flask import Flask, render_template


app = Flask(__name__)


@app.route("/")
def main():
    return render_template("index.html", env_data=get_my_env())


@app.route("/app")
def hello():
    return render_template("app.html", env_data=get_my_env())


def get_my_env():
    """
    This function will return my requird envs and return as dict.
    """
    return {
        "NODE_IP": environ.get("NODE_IP"),
        "POD_IP": environ.get("POD_IP"),
        "HOSTNAME": environ.get("HOSTNAME"),
    }


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(app_info().get("APP_PORT", 5000)))
