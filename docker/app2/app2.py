# Code for microservice 2
from flask import Flask, jsonify

app = Flask(name)

@app.route('/')
def hello():
    return jsonify(message="Hello from App2!")

@app.route('/health')
def health():
    return jsonify(status="healthy")

if name == 'main':
    app.run(host='0.0.0.0', port=80)
