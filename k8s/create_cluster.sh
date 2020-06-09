echo "Create Cluster on AWS"
eksctl create cluster \
--name udacity-devops \
--version 1.16 \
--region us-east-1 \
--zones=us-east-1a,us-east-1b \
--nodegroup-name standard-workers \
--node-type t2.small \
--nodes 2 \
--nodes-min 1 \
--nodes-max 3 \
--node-ami auto

echo "Deploy blue image"
kubectl apply -f k8s/blue-controller.yml

echo "Deploy green image"
kubectl apply -f k8s/green-controller.yml

echo "Create service exposing blue"
kubectl apply -f k8s/blue-service.yml
