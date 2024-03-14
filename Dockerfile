FROM python:3.9.16-slim-buster

WORKDIR /app

COPY requirement.txt .


RUN pip3 install --no-cache-dir -r requirement.txt

COPY . .

#ENV FLASK_APP="utility.py"
#env FLASK_APP="utility.py python -m flask run"

ENV FLASK_APP=utility.py
#ENV FLASK_DEBUG=1
#ENV FLASK_RUN_PORT=8090
CMD ["flask","run","--host=0.0.0.0"]
#CMD ["python3", "-m", "flask", "run", "--host=0.0.0.0", "--port", "8080"]