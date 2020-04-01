#!/bin/bash

# $ kubeadm config images list --kubernetes-version v1.18.0
# W0331 14:00:15.856618   19761 configset.go:202] WARNING: kubeadm cannot validate component configs for API groups [kubelet.config.k8s.io kubeproxy.config.k8s.io]
# k8s.gcr.io/kube-apiserver:v1.18.0
# k8s.gcr.io/kube-controller-manager:v1.18.0
# k8s.gcr.io/kube-scheduler:v1.18.0
# k8s.gcr.io/kube-proxy:v1.18.0
# k8s.gcr.io/pause:3.2
# k8s.gcr.io/etcd:3.4.3-0
# k8s.gcr.io/coredns:1.6.7

## 使用如下脚本下载国内镜像，并修改tag为google的tag
set -e

KUBE_VERSION=v1.18.0
KUBE_PAUSE_VERSION=3.2
ETCD_VERSION=3.4.3-0
CORE_DNS_VERSION=1.6.7

GCR_URL=k8s.gcr.io
ALIYUN_URL=registry.cn-hangzhou.aliyuncs.com/google_containers

images=(kube-proxy:${KUBE_VERSION}
        kube-scheduler:${KUBE_VERSION}
        kube-controller-manager:${KUBE_VERSION}
        kube-apiserver:${KUBE_VERSION}
        pause:${KUBE_PAUSE_VERSION}
        etcd:${ETCD_VERSION}
        coredns:${CORE_DNS_VERSION})

for imageName in ${images[@]} ; do
    docker pull $ALIYUN_URL/$imageName
    docker tag  $ALIYUN_URL/$imageName $GCR_URL/$imageName
    docker rmi $ALIYUN_URL/$imageName
done
