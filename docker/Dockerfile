FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV APP_ENV=dev
ENV APP_VERSION=1.0.0

WORKDIR /app

RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ .

RUN chown -R appuser:appgroup /app
USER appuser

EXPOSE 8080

CMD ["gunicorn", "-c", "gunicorn.conf.py", "app:app"]