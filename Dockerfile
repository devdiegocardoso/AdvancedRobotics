FROM python:3.12-slim

RUN pip install --no-cache-dir sympy

WORKDIR /app

CMD ["python"]
