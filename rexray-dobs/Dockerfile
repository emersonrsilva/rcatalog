FROM --platform=linux/amd64 golang:1.22.2

WORKDIR /go/src/github.com/rancher/storage
RUN apt-get update && \
    apt-get install -y jq dnsutils e2fsprogs curl  fuse
run go install github.com/googlecloudplatform/gcsfuse/v2@master
# Build and install Rancher storage plugin
RUN curl -sSOL https://github.com/rancher/storage/archive/v0.8.2.tar.gz && \
    tar xvf v0.8.2.tar.gz -C /go/src/github.com/rancher/storage/ --strip-components 1 && \
    cp -rf vendor/* /go/src/ && \
    ls && \
    go env -w GO111MODULE=off && \
    go build && \
    go install && \
    cp -rf package/common/* /usr/bin/
COPY envs.go .
run go build -o env-printer envs.go
run cp env-printer /usr/bin
run chmod +x /usr/bin/env-printer

ENV RANCHER_SSL_SCRIPT_COMMIT=98660ada3d800f653fc1f105771b5173f9d1a019

RUN curl -sL https://raw.githubusercontent.com/rancher/rancher/${RANCHER_SSL_SCRIPT_COMMIT}/server/bin/update-rancher-ssl > /usr/bin/update-rancher-ssl && \
    chmod +x /usr/bin/update-rancher-ssl

# Clean environment
WORKDIR /go
RUN rm -rf /go/src/*
ADD google-storage /usr/bin/

CMD ["start.sh", "storage", "--driver-name", "google-storage"]
