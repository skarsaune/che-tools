#!/bin/bash
#
# Simple sync script only using kubectl , be aware that this is a very limited script
# Ideally sync all your changes between different environments using git

WKS_POD=`kubectl get pods --all-namespaces |grep workspace|head -1| awk '{print $1"/"$2}'`

if [ "$WKS_POD" = "" ]
then
    echo "Could not find any workspace pod with kubectl" && exit 2
fi

#Initially fetch project from pod into the folder of this script
echo fetching all files from che
kubectl cp $WKS_POD:/projects projects -c tools
touch lastSynced
#Start syncing back
echo "Pushing detected changes back to che, press ^C to abort"
while true
do
    sleep 3s;
    echo -n .
    for updatedFile in $(find projects -type f -Bnewer lastSynced | grep -v '/target/')
    do
	echo syncing $updatedFile to che
	kubectl cp $updatedFile $WKS_POD:/$updatedFile -c tools
    done
    touch lastSynced
done

