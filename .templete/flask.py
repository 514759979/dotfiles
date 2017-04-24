#!/usr/bin/python

from flask import Flask, url_for
app = Flask(__name__)

@app.route('/')
def root():
    return 'Hello World!'

@app.route('/test')
def test():
    return 'test'


if __name__ == '__main__':
    app.run(host = '0.0.0.0', port = 8080, debug = True)
