# what is it

An application that shows how many times the index page is loaded and - if (sleep)[0] is called - spin up a worker tasks.

# how is made

The application consists of three container:

- web: a flask application 
- redis: acts as the 'database' to the web app and the worker
- worker: whenever a task it's created the worker processes it

# run locally

docker-compose up

And then test the application with

curl http://localhost:5000

Or via browser.

Long running task is triggered by going to

curl http://localhost:5000/sleep

# deployment

Automatic deployment is done trough Jenkins (see Jenkinsfile):

- stage 1: build containers
- stage 2: run tests
- stage 3: if tests are successful it deploys the application trough AWS Beanstalk
