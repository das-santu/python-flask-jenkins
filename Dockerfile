FROM python:3.10-alpine

WORKDIR /python-docker

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

RUN apk add --update curl

COPY . .

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
