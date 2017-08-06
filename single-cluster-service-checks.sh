#!/bin/bash

#getting the cluster name
echo "Please, write the cluster name"
read aws_cluster

echo "Specify the region"
read aws_region

#getting the services names
aws ecs list-services --cluster $aws_cluster --region $aws_region | awk -F ':|"|/' '{print $8}' | awk NF > services.txt

#now reading files, sed'ing parameters
while IFS='' read -r service_name || [[ -n "$service_name" ]]; do
	cp ecs-named-service-check.json $aws_cluster-$service_name-service-check.json
	sed -i '' "s/foo/$aws_cluster/;s/bar/$service_name/" $aws_cluster-$service_name-service-check.json
    	echo "Done for service: $service_name"
done < services.txt
rm services.txt
