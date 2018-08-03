# What is it

An application that shows how many times the index page is loaded and - if (sleep)[0] is called - spin up a worker tasks.

# How is made

The application consists of three container:

- web: a flask application 
- redis: acts as the 'database' to the web app and the worker
- worker: whenever a task it's created the worker processes it

#### Run locally

```
docker-compose up
```

And then test the application with

```
curl http://localhost:5000
```

Or via browser.

Long running task is triggered by going to

```
curl http://localhost:5000/sleep
```


#### Push docker image

```
docker login
docker tag testpythondocker_website $DOCKER_ID_USER/flasktest
docker push $DOCKER_ID_USER/flasktest
```

#### Deployment

Automatic deployment is done trough Jenkins (see Jenkinsfile):

- stage 1: build containers
- stage 2: run tests
- stage 3: if tests are successful it deploys the application trough AWS Beanstalk

# Infrastructure

I have added some terraform scripts that sets up a kubernetes cluster on Azure (aks).

## Resources creation via terraform

NOTE: state is stored locally in this simple scenario. If you work in a team state should be stored remotely.

### Setup

- choose subscription id from `az account list --output table`
- get tenant id with `az account show --output json | jq -r '.tenantId'`
- client id and client secret have to be fetched from [azure ad](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/resource-group-create-service-principal-portal). Create a new app registration or use an existing one (you will need to create a new secret key in that case)

### Env variable setup

```
export TF_VAR_subscription_id=<subscription_id>
export TF_VAR_client_id=<client_id>
export TF_VAR_client_secret=<client_secret>
export TF_VAR_tenant_id=<tenant_id>
```

### Terraform init

Terraform commands have to be run from `infra` directory.
If the state is remote you might want to initialize terraform this way:

```
terraform init -backend-config="storage_account_name=$STORAGE_ACCOUNT_NAME_IN_WHICH_THE_STATE_IS_STORED" \
                                -backend-config="container_name=tfstate" \
                                -backend-config="access_key=$STORAGE_ACCESS_KEY" \
                                -backend-config="key=codelab.microsoft.tfstate" 
```

In this case, initialize terraform to use local state with:

```
terraform init
```

We will have a separate state per environment.
State is separated through [workspaces](https://www.terraform.io/docs/state/workspaces.html)

```
terraform workspace new {dev,stg,pro,...}
terraform workspace list
terraform workspace select {dev,stg,pro,...}
```

### Validation

Check if kubernetes cluster is good with:

```
export ENV=dev
az aks get-credentials --resource-group testapp-$ENV --name testapp-$ENV
kubectl get nodes
```

# Kubernetes

Helm commands have to be run from the project's root folder.

NOTE: the container image has to be in a public repository

## Helm

There is a local helm chart that sets up the whole application stack on the cluster.

NOTE: this does not setup rbac, so your cluster and helm is insecure, do not run it in production.

```
export ENV=dev
helm init
helm install --namespace testapp-dev ./helm_chart/
```

# Termination

Delete the cluster and all the resources associated with `terraform destroy`.
