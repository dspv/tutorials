##############
### Basics ###
##############

# runs nginx container
docker run nginx 
# runs a specific image
docker run ubuntu:17.10

# shows containers running now
docker ps
# shows all the container launched
docker ps -a
# shows images
docker images

# stops container
docker stop nginx
# removes container
docker rm nginx
# removes image
docker rmi nginx

# runs container in detached mode -- means in background
docker -d nginx
# runs container in interactive mode
docker -it nginx
# attach container
docker attach nginx

# runs ubuntu and executes command
docker run ubuntu sleep 100
# example: shows current version
docker run ubuntu cat /etc/*release*
# runs ubuntu in interactive mode with terminal and runs bash, so we can interact with it
docker run -it ubuntu bash



#############################
### ADVANCED RUN COMMANDS ###
#############################

# show more info about the container
docker inspect nginx

# runs mysql container
docker run mysql
# run mysql container and maps docker host port (8080) to container port (5000)
docker run -p 8080:5000 mysql
# example with webapp: runs webapp in detached mode and maps container's port 5000 to 8080 (docker host port)
docker run -d -p 8080:5000 kodekloud/webapp
# mount external directory and data stays safe even if container is destroyed
docker run -v /opt/datadir/var/lib/mysql mysql

# provide info about container
docker inspect busybox 

# logs from the container blissful_hopper
docker logs blissful_hopper

### Example ###
# We run Jenkins, set it up, etc.
# But when we stop this container and run a new one again... our data is gone (lost)
# So, Jenkins recommends to mount a volume for it
# Example: (from the docs)
docker run --name myjenkins -p 8080:8080 -p 50000:50000 -v /your_home:/var/jenkins_home jenkins
# or this way
mkdir my-jenkins-data
docker run -p 8080:8080 -v /root/my-jenkins-data:/var/jenkins_home -u root jenkins
# means:
# -p 8080:800 -- port mapping from 8080 from host to 8080 to container's port
# -v mount my volume to jenkins's volume to save and keep data
# -u root - username specified


### Enviroment Variables ###
# here we run simple-webapp-color and set up Envuroment Variable APP_COLOR to 'blue'
# to make it work we need to have it moved from the code to enviroment variables
docker run -e APP_COLOR=blue simple-webapp-color

# how to find?! RUN this and take a look at Config --> Env --> [here]
docker inspect [container_name]



#####################
### Dockerization ###
#####################

### Create my own image ###
# Create a Dockerfile:
FROM ubuntu
RUN apt-get update
RUN apt-get install python

RUN pip install flask
RUN pip install flask-mysql

COPY . /opt/source-code

ENTRYPOINT FLASK_APP=/opt/source_code/app.py flask run

# build the image from Dockerfile (dspv1 -- my login on Docker Hub)
docker build Dockerfile -t dspv1/my-custom-app
# the push it to Docker Hub (Docker Registry)
docker push dspv1/my-custom-app
# docker login to registry
docker login



######################
### Docker Compose ###
######################

docker run mmushad/simple-webapp
docker run mongodb
docker run redis:alpine
docker run ansible

# to save time we can combine everytihng at one file docker compose

# docker-compose.yml:
services:
    web:
        image: "mmumshad/simple-webapp"
    database:
        image: mongodb
    messaging:
        image: redis:alpine
    orchestration:
        images: ansible

# and then compile all together
doker-compose up

### Simple voting application ###
# voting-app (python)
# in-memory db (redis)
# worker (.net)
# db (postgre)
# result-app (node.js)

# deploy containers with docker and link them
docker run -d --name=redis redis
docker run -d --name=db postgres:9.4
docker run -d --name=vote -p 5000:80 --link redis:redis voting-app
docker run -d --name=result -p 5001:80 --link db:db result-app
docker run -d --name=worker --link db:db --link redis:redis worker

# generate docker-compose.yml:
redis:
    image: reids
db:
    image: postgres:9.4
vote:
    image: voting-app
    ports:
        - 5000:80
    links:
        - redis
result:
    image: result-app
    ports:
        - 5001:80
    links:
        - db
worker:
    image: worker
    links:
        - db
        - redis
#
# then
doker-compose up

# One more thing. If we don't have some images ready,
# We can specify how and where to build those images 
# in the same docker-compose file

# generate docker-compose.yml with builds:
redis:
    image: reids
db:
    image: postgres:9.4
vote:
    build: ./vote # build instead of image
    ports:
        - 5000:80
    links:
        - redis
result:
    build: ./result # build instead of image
    ports:
        - 5001:80
    links:
        - db
worker:
    build: ./worker # build instead of image
    links:
        - db
        - redis

# New docker-compose.yaml with networks (v.2)
version: 2
services:
    redis:
        image: redis
        networks:
            - back-end
    db:
        image: postgres:9.4
        networks:
            - back-end
    vote:
        image: voting-app
        networks:
            - front-end
            - back-end
    
    result:
        image: result
        networks:
            - front-end
            - back-end

networks:
    front-end:
    back-end:



###############
### Volumes ###
###############

# docker files located in 
# /var/lib/docker
# --volumes

# create volume
docker volume create data_volume

# mount volume with -v option (legacy) -- location within /var/lib/docker/
docker run -v data_volume:/var/lib/mysql mysql
# mount (bind) any location
docker run -v /data/mysql:/var/lib/mysql mysql

# mount volume in a modern way
docker run \
--mount type-bind,source=/data/mysql,target=/var/lib/mysql mysql

# note!, that mounting directory within /var/lib/docker/volumes -- means mounting volumes
# mounting any directory like /data/... -- means binding



##################
### Networking ###
##################

# there 3 networks:
# - bridge (default one) CIDR: 172.17.0.0/16
# - none (isolated) - not attached to any network, means fully isolated
# - host (means 'mapped to the host') - no isolation from host - no need to map any port

# create a networ
docker network create \
--driver bridge \
--subnet 182.18.0.0/16 \
custom-isolated-network

# check all the networks
docker network ls

# container association:
# runs ubuntu in [name] network
docker run ubuntu
docker run ubuntu --network=none
docker tun ubuntu --network=host

# example
# run mysql:5.6 images named 'mysql-db' in network 'wp-mysql-network' 
# and set up enviroment variable (root password) MYSQL_ROOT_PASSWORD=db_pass123
docker run --name=mysql-db --network=wp-mysql-network -e MYSQL_ROOT_PASSWORD=db_pass123 mysql:5.6

###############
### The End ###
###############