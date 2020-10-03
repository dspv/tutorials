#### This is a 2nd version ####

# add new pod from image nginx
kubectl run nginx --image nginx
kubectl run redis --image redis
kubectl run python --image python3:alpine

# shows all the pods aer running
kubectl get pods

### YAML ###
## We use pod-definition.yml

kubectl get all

# dry run
# does not create the pod but creates yaml file pod.yaml
kubectl run redis --image=redis123 --dry-run=client -o yaml > pod.yaml
# then we can deploy this
kubectl apply -f pod.yaml
# we can edit this pod
kubectl edit pod redis
# in this case (if you use edit) we don't need to re-deploy it

# change config for scaling, etc
# imagine we had a replicaset create from file rs-def.yml
# we deployed it as
kubectl create -f rs-def.yml
# then we updated the file rs-def.yml and need to update the replicaset
kubectl replace -f rs-def-yml
# or, we can scale it directly
kubectl scale --replicas=6 -f rs-def.yml
# or this way where we just scale the existing replicaset
kubectl scale --replicas=6 replicaset myapp-replicaset

# again...
# create any object defined in this file (file.yml) - We can use both: create & apply as well
kubectl create -f file.yml 
kubectl apply -f file.yml
# shows all the replicasets
kubectl get replicaset
# we can delete the replicaset named 'myapp-replicaset' and the all underlying pods
kubectl delete replicaset myapp-replicaset
# we can scale or replace with a new version in file.yml
kubectl replace -f file.yml
# scale replicaset without(!) modifying file
kubect scale --replicas=6 -f file.yml

# described deployment 'frontend-deployment' and shows exactly 'image'
kubect describe deployments frontend-deployment | grep -i image

####################
#### Namespaces ####
####################
# shows pods in the default namespace
kubectl get pods 
# shows pods in the namespace 'kube-system'
kubectl get pods --namespace=kube-system

# create pods
# create pod in the default namespace
kubectl create -f pod-def.yml

# to create pos in the 'dev' namespace use:
kubectl create -f pod-def.yml --namespace=dev

# if we move << namespace: dev >> in the yaml file it will be created in this namespace
# pod-def.yml:
apiVersion: v1
kind: Pod
metadata:
    name: myapp-pod
    namespace: dev  # << here's NAMESPACE used. So we don't need to use --namespace=dev when do KUBECTL
    labels: 
        app: myapp
        type: front-end
spec:
    containers:
        - name: nginx-containers
            image: nginx

# to deploy
kubect create -f pod-def.yml
# and it deploys pod in the 'dev' namespace

## how to create a namespace
# namespace-dev.yml
apiVersion: v1
kind: Namespace
metadata:
    name: dev

# and deploy it
kubectl create -f namespace-dev.yml
# or simply create a 'dev' namespace using kubectl command
kubectl create namespace dev

# change the default namespace where commands will be executed. Here we switch from 'default' to 'dev' namespace
kubectl config set-context $(kubect config current context) --namespace=dev
# change to prod
kubectl config set-context $(kubect config current context) --namespace=prod

# this how we can get pods then:
kubectl get pods --namespace=dev
kubectl get pods --namespace=default

# show all pods in all namespaces
kubectl get pods --all-namespaces

# show all namespaces
kubectl get namespaces
kubectl get ns

# show how many namespaces (ns) there are 
kubectl get ns --no-headers | wc -l

# get pods in namespace 'research'
kubectl get pods --namespace=research
kubectl -n research get pods

# get all pods from all namespaces and find the pod we need (blue)
kubectl get pods --all-namespaces | grep blue

##################
#### Services ####
##################

#### NodePort ####
# service-definition.yml
apiVersion: v1
Kind: Services
metadata:
    name: myapp-service
spec:
    type: NodePort
    ports:
        - targetPort: 80
            port: 80
            nodeport: 300008
    selector: # here we put labels from the pod-definition.yml
        app: myapp
        type: front-end

# deploy
kubectl create -f service-definition.yml

# check services
kubectl get services
# check the target
curl http://192.168.1.2:30008

# describes service 'kubernetes'
kubectl describe svc kubernetes

### Imperative approach ###
# expose can help to change smth in the service etc
kubectl expose ...

# let's say we deploy nginx as is
kubectl run nginx --image=nginx
# make a deployment
kubectl create deployment --image=nginx nginx
# then we want to set/change the port
kubectl expose deployment nginx --port=80
# or we can edit it
kubectl edit deployment nginx
# and finally scale it
kubectl scale deployment nginx --replicas=5
# we can also change an image inside
kubectl set image deployment nginx nginx=nginx:1.18

# we can use -f and files to
kubectl create -f nginx.yaml
kubectl replace -f nginx.yaml
kubectl delete -f nginx.yaml

###########################

### Declarative approach ###
kubectl apply -f nginx.yaml 

############################

kubect run httpd --image=httpd:alpine --port 80 --expose 
