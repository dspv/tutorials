import psycopg2

# connect to the server
conn = psycopg2.connect("dbname=postgres user=Rose")

# obtain cursor object for this connection
cur = conn.cursor()

# execute SQL query
cur.execute("CREATE TABLE users;")

# commit changes
conn.commit()

# close the connection
conn.close()

#############
## EXAMPLE ##
#############
#import psycopg2
#conn = psycopg2.connect("dbname=dq user=dq")
#cur = conn.cursor()
#cur.execute("INSERT INTO users VALUES (%s, %s, %s, %s);", (1, "hello@dataquest.io", "John", "123, Fake Street"))
#conn.commit()


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

Save it to a file, make necessary changes to the file (for example, adding more replicas) and then create the deployment.
