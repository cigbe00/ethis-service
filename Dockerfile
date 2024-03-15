FROM python:3.9.16-slim-buster

# Create app work directory
WORKDIR /app

# copy dependency list
COPY requirement.txt .

# Install dependencies
RUN pip3 install --no-cache-dir -r requirement.txt
#RUN ["pytest"]

# Copy app code
COPY . .

EXPOSE 8090
ENV FLASK_APP=utility.py
#CMD ["flask","run","--host=0.0.0.0"]
CMD ["python3", "-m", "flask", "run", "--host=0.0.0.0", "--port", "8090"]