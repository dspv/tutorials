#################################
### Kubernetes Best Practises ###
#################################
### Source: https://youtu.be/wGz_cbtCiEA ###

# ---------------------------- #
# 1. Building Small Containers #
# ---------------------------- #

# Means we create a first container, build everything inside
# Then take only needed files and make a new container
# So we make the second (another) containce inside a first one

# compile code
FROM golang:alpine AS build-end
WORKDIR /app
ADD . /app
RUN cd /app && go build -o goapp

# get compiled files
FROM alpine
RUN apk update
RUN apk add ca-certificates
RUN rm -rf /var/cache/apk/*
WORKDIR /app
COPY --from=build-env /app/goapp /app

EXPOSE 8080
ENTRYPOINT ./goapp