# Simple Web Application

This is used in the demonstration of Simple Web Application.
  
  Below are the steps required to get this working on a base linux system.
  
  - Install all required dependencies
  - Install and Configure Web Server
  - Start Web Server
   
## 1. Install all required dependencies
  
  Python and its dependencies

    pip3 install -r requirements.txt

   
## 2. Install and Configure Web Server

Install Python Flask dependency

    pip install flask

- Copy app.py or download it from source repository
- Configure database credentials and parameters 

## 3. Start Web Server

Start web server

    FLASK_APP=app.py flask run --host=0.0.0.0
    
## 4. Test

Open a browser and go to URL

    http://<IP>:5000                      => Welcome
    http://<IP>:5000/app                  => This is the App Section!!
