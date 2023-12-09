FROM python:3.10-slim

RUN apt-get update && apt-get install -y curl

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

CMD [ "python", "-m" , "flask", "run", "--host=0.0.0.0"]
