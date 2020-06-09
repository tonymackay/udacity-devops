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