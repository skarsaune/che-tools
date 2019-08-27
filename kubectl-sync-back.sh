#!/bin/bash
#
#
# Requires https://github.com/ernoaapa/kubectl-warp
#

if [ $? -ne 0 ]
then
    echo "Could not find any workspace pod with kubectl" && exit 2
fi

WKS_POD=`kubectl get pods --all-namespaces |grep workspace|head -1| awk '{print $1"/"$2}'`


#Initially fetch project from pod into the folder of this script
echo fetching all files from che
kubectl cp $WKS_POD:/projects projects -c tools
touch lastSynced 
#Start syncing back
echo "Pushing detected changes back to che, press ^C to abort"
while true
do
    sleep 3s;
    for updatedFile in $(find projects -type f -Bnewer lastSynced | grep -v '/target/')
    do
	echo syncing $updatedFile to che
	kubectl cp $updatedFile $WKS_POD:/$updatedFile -c tools
    done
    touch lastSynced
done

	