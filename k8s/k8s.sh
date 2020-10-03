# creates a pod and deploys nginx container on the node
kubectl run nginx

# select image from docker hub
kubectl run nginx --image nginx

# shows pods running
kubectl get pods

# creates pods based on pod-definition.yml config
kubectl create -f pod-definition.yml 

# describes pod - all data about this pod
kubectl describe pod myapp-pod

# create replication accroding to rc-definition.yml
kubectl create -f rc-definition.yml

##################

## Deployment
# deploy pods according to the file
kubectl create -f deployment-definition.yml
# check the deployment
kubectl get deployments
# check the replicaset
kubectl get replicaset
# check pods
kubectl get pods
# show me all the things
kubectl get all


## Commands instead of using YAML
# Create an NGINX Pod
kubectl run --generator=run-pod/v1 nginx --image=nginx

# Generate POD Manifest YAML file (-o yaml). Don't create it(--dry-run)
kubectl run --generator=run-pod/v1 nginx --image=nginx --dry-run -o yaml

# Create a deployment
kubectl create deployment --image=nginx nginx

# Generate Deployment YAML file (-o yaml). Don't create it(--dry-run)
kubectl create deployment --image=nginx nginx --dry-run -o yaml

# Generate Deployment YAML file (-o yaml). Don't create it(--dry-run) with 4 Replicas (--replicas=4)
kubectl create deployment --image=nginx nginx --dry-run -o yaml > nginx-deployment.yaml


### Namespaces ###
# shows pods in 'kube-system' namespace
kubectl get pods --namespace=kube-system

# create pods in namespace 'dev'
kubectl create -f pod-definition.yml --namespace=dev

# how to specify namespace:
# namespace-dev.yml:
apiVersion: v1
kind: Namespace
metadata:
    name: dev

# and make:
kubectl create -f namespace-dev.yml

# change the default namespace:
kubectl config set-context $(kubectl config current-context) --namespace=dev
# and then:
kubectl get pods
# how to use default
kubectl get pods --namespace=default 

kubectl get pods --all-namespaces 

#### We can define a resources quote with config file as well
# compute-quota.yml:
apiVersion: v1
kind: ResourceQuota
metadata:
    name: conpute-quota
    namespace: dev

spec:
    hard:
        pods: '10'
        requests.cpu: '4'
        requests.memory: 5Gi
        limits.cpu: '10'
        limits.memory: 10Gi

# and then make
kubectl create -f compute-quota.yml

####################
##### SERVICES #####
####################

### Node Port ###
# service-definition.yml
apiVersion: v1
kind: Service
metadata:
    name: myapp-service

spec:
    type: NodePort
    ports:
        - targetPort: 80
         port: 80
         nodePort: 30008
    selector: 
        app: myapp
        type: front-end

# then deploy it:
kubectl create -f service-definition.yml

# chech services
kubectl get services

### Cluster IP ###
# service-definition.yml
apiVersion: v1
kind: Service
metadata:
    name: back-end

spec:
    type: ClusterIP
    ports:
        - targetPort: 80
            port: 80
    
    selector:
        app: myapp
        type: back-end
# then deploy it:
kubectl create -f service-definition.yml

### Load Balancer ###

#####################
### Some commands ###
#####################

# create objects
kubectl run --image=nginx nginx
kubectl create deployment --image=nginx nginx
kubectl expose deployment nginx --port 80

# update objects
kubectl edit deployment nginx
kubectl scale deployment nginx --replicas=5
kubectl set image deployment nginx nginx=nginx:1.18


#################
-----------------
=== EXAM TIPS ===
-----------------
#################

--dry-run  
# By default as soon as the command is run, the resource will be created

--dry-run=client
# This will not create the resource, 
# instead, tell you whether the resource can be created and if your command is right

-o yaml
# This will output the resource definition in YAML format on the screen.



# In this lab, you will get hands-on practice with creating Kubernetes objects imperatively.
####################################################
# All the questions in this lab can be done imperatively. 
# However, for some questions, you may need to first create the YAML file using imperative methods. 
# You can then modify the YAML according to the need and create the object using 
kubectl apply -f command.


# set tier
kubectl run redis --image=redis:alpine -l tier=db

# expose redis to service
kubectl expose pod redis --port=6379 --name redis-service

kubectl run custom-nginx --image=nginx --port=8080

# Step 1: Create the deployment YAML file
kubectl create deployment redis-deploy --image redis --namespace=dev-ns --dry-run=client -o yaml > deploy.yaml

# Step 2: Edit the YAML file and add update the replicas to 2

# Step 3: Run kubectl apply -f deploy.yaml to create the deployment in the dev-ns namespace.
# You can also use kubectl scale deployment or kubectl edit deployment to change the number of replicas once the object has been created.