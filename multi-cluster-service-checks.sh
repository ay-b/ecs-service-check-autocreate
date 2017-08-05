#!/bin/bash

#getting the cluster names, storing them in file
aws ecs list-clusters | awk -F ':|"|/' '{print $8}' | awk NF > clusters.txt
while IFS='' read -r aws_cluster || [[ -n "$aws_cluser" ]]; do
	#getting the services names, storing them in file
	aws ecs list-services --cluster $aws_cluster | awk -F ':|"|/' '{print $8}' | awk NF > services.txt

	#now reading files, sed'ing parameters
	while IFS='' read -r line || [[ -n "$line" ]]; do
		cp ecs-named-service-check.json ecs-$line-service-check.json
		sed -i '' "s/foo/$aws_cluster/;s/bar/$line/" ecs-$line-service-check.json
	    	echo "Done for service: $line"
	done < services.txt
done < clusters.txt
rm clusters.txt
rm services.txt
