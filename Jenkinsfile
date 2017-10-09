def appEnvName = ""
def SECRET_KEY_BASE = ""
def AWS_REGION = "eu-west-1"

node ('master') {
  checkout scm

  def commitHash = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
  def projectName = 'testdocker'
  def branchName = sh(returnStdout: true, script: 'git rev-parse HEAD | git branch -a --contains | grep remotes | sed s/.*remotes.origin.//').trim()
  def TAG = commitHash

  def DOCKER_IMAGE_REPO = 'xxxxxxxxxxxx.dkr.ecr.eu-west-1.amazonaws.com'
  def DOCKER_IMAGE_NAME = 'testdocker'

  if(branchName == 'master'){
    appEnvName = projectName + '-prod'
  }
  else if(branchName == 'staging'){
    appEnvName = projectName + '-staging'
  }

  stage ('Build containers') {
    sh "docker-compose build"
  }

  stage ('Run tests') {
    sh "docker-compose run website /bin/echo 'test pass'" # TODO: run proper tests
    sh "docker-compose ps"
    sh "docker-compose stop"
    sh "docker-compose rm -f"
  }

  stage ('Deploy container') {
    if(branchName == 'master' || branchName == 'staging'){
      
      sh "aws ecr get-login --region eu-west-1 | bash"

      sh "docker tag python-docker-redis_website:latest $DOCKER_IMAGE_REPO/$DOCKER_IMAGE_NAME:$TAG"
      sh "docker push $DOCKER_IMAGE_REPO/$DOCKER_IMAGE_NAME:$TAG"

      envsubst < Dockerrun.aws.json.tmpl > Dockerrun.aws.json

      zip -FSj deploy.zip Dockerrun.aws.json

      sh "eb deploy $appEnvName -l $TAG"
    }
  }
}
