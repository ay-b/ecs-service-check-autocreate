#!/bin/bash

#getting the cluster name
aws ecs list-clusters | awk -F ':|"|/' '{print $8}' | awk NF > clusters.txt
while IFS='' read -r aws_cluster || [[ -n "$aws_cluser" ]]; do
	#getting the services names
	aws ecs list-services --cluster $aws_cluster | awk -F ':|"|/' '{print $8}' | awk NF > services.txt

	#now reading files, sed'ing parameters
	while IFS='' read -r service_name || [[ -n "$service_name " ]]; do
		cp ecs-named-service-check.json $aws_cluster-$service_name -service-check.json
		sed -i '' "s/foo/$aws_cluster/;s/bar/$service_name /" $aws_cluster-$service_name -service-check.json
	    	echo "Done for service: $service_name "
	done < services.txt
done < clusters.txt
rm clusters.txt
rm services.txt
