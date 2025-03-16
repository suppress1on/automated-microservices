# Dockerfile to build an app1-img
FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY app1.py .

CMD ["python", "app.py"]

