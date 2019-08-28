#!/bin/bash

kubectl cp index-jz.json che/devfile-registry-74cbd5d77c-p2jkc:/var/www/html/devfiles/index.json
kubectl cp devfiles/javazone che/devfile-registry-74cbd5d77c-p2jkc:/var/www/html/devfiles