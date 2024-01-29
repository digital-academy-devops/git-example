### Builder ###
FROM alpine:latest as builder

RUN apk add -U --no-cache bash ruby
RUN gem install yaml-cv

# Sources
ARG YQ_VERSION=v4.29.2
ARG YQ_BINARY=yq_linux_amd64
ARG TASK_VERSION=v3.17.0
ARG TASK_BINARY=task_linux_amd64.tar.gz

RUN wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY} -O /usr/bin/yq &&\
    chmod +x /usr/bin/yq

RUN wget -O- https://github.com/go-task/task/releases/download/${TASK_VERSION}/${TASK_BINARY} \
    | tar xz -C /usr/bin

# Build export
WORKDIR /opt/app

COPY src/ src/
COPY scripts/ scripts/
COPY .env .env
COPY Taskfile.yaml Taskfile.yaml

ENTRYPOINT ["/usr/bin/task"]

### Builder build
FROM builder as build
WORKDIR /opt/app
RUN task build

### Exporter ###
FROM busybox as release

WORKDIR /opt/app
COPY --from=build /opt/app/build/cv.html cv.html
VOLUME /opt/app
