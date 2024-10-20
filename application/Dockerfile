FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY . /app

RUN pytest --disable-warnings

EXPOSE 5000

CMD ["python", "app.py"]