import json


def app_info():
    with open("version.json") as app_file:
        app_info = json.load(app_file)
    return app_info
