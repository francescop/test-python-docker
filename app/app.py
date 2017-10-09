from flask import Flask
from rq import Queue
from worker import conn
from utils import long_running_task

import redis
import os

app = Flask(__name__)

app.debug = True
db = redis.Redis(os.getenv('REDIS_HOST', 'localhost'))
q = Queue('tasks', connection=conn)

@app.route('/')
def home():
    view_key = '{}:{}'.format('view-count', 'home')
    db.incr(view_key)
    view_count = db.get(view_key) or 0
    return "Counter: " + str(view_count)

@app.route('/sleep')
def sleep():
    q.enqueue(long_running_task, 5)
    return 'task created'
