import os
from flask import Flask
app = Flask(__name__)

@app.route("/")
def main():
    return "Welcome!"

@app.route('/app')
def hello():
    return 'This is the App Section!!'

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
