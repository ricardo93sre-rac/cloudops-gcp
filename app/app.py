from flask import Flask, jsonify
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST
import os
import socket
import time

app = Flask(__name__)

REQUEST_COUNT = Counter(
    "flask_app_requests_total",
    "Total HTTP requests processed by the Flask app"
)

START_TIME = time.time()

@app.route("/")
def home():
    REQUEST_COUNT.inc()
    return jsonify({
        "message": "Hola desde Flask en GCP DevOps Lab",
        "hostname": socket.gethostname(),
        "environment": os.getenv("APP_ENV", "dev"),
        "version": os.getenv("APP_VERSION", "1.0.0")
    })

@app.route("/healthz")
def healthz():
    return jsonify({
        "status": "ok",
        "uptime_seconds": round(time.time() - START_TIME, 2)
    }), 200

@app.route("/metrics")
def metrics():
    return generate_latest(), 200, {"Content-Type": CONTENT_TYPE_LATEST}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)