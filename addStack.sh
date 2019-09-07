#!/bin/bash

DEV_REG=$(kubectl get pods --all-namespaces |grep devfile-registry|awk '{print $1"/"$2}')
kubectl cp index-jz.json $DEV_REG:/var/www/html/devfiles/index.json
kubectl cp devfiles/javazone $DEV_REG:/var/www/html/devfiles