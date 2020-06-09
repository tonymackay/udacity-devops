# Udacity Cloud DevOps Engineer Capstone
This is final capstone project for the Udacity Cloud DevOps Engineer program. It contains a simple Node app called `stocks-api` that runs in a Docker container on a Kubernetes cluster. The project demonstrates the ability to setup a Jenkins CI/CD pipeline using the blue/green deployment strategy. 

There is one endpoint exposed once app has been deployed to the AWS k8s cluster.  It is `/quote?symbol=TSLA`. It returns the following example JSON response:

```
[{
  "symbol": "TSLA",
  "price": 949.92,
  "previousPrice": 885.66,
  "currency": "USD"
}]
```

The endpoint supports multiple stock quotes by appending multiple `&symbol=GOOG` to the query string.   

## Steps to Setup 

1. Install Jenkins on Ubuntu Server 18.04.
2. Install the Blue Ocean plugin.
3. Install CloudBees AWS Credentials Plugin. 
4. Install the latest version of Docker, Node and the AWS CLI on the Jenkins server.
5. Add AWS secret to credentials store with name of `aws-secret`.
6. Add Docker Username and Password to the credentials store with name of `docker-hub`.
7. Create a new pipeline using Blue Ocean UI and connecting to this repo.

Run the `./create_cluster.sh` script to build the AWS k8s cluster and deploy version 1 of the app into blue and green images.

```
./k8s/create_cluster.sh
```

Once the cluster has been created it's time to make a change to the app then push it to GitHub. Jenkins will run the pipeline, the first stage will do a lint test to make sure the JavaScript is valid. After that the docker image will be built and deployed to Docker hub, then the image will be deployed to the green app in the k8s controller. You will be asked to confirm traffic switch to the green image. After switching you can test to make sure the app is working okay and then confirm you wan the old blue image updated as well.

