#!/bin/bash

#getting the cluster name
export aws_cluster=$(aws ecs list-clusters | awk -F ':|"|/' '{print $8}' | awk NF)

#getting the services names
aws ecs list-services --cluster $aws_cluster | awk -F ':|"|/' '{print $8}' | awk NF > services.txt

#now reading files, sed'ing parameters
while IFS='' read -r line || [[ -n "$line" ]]; do
	cp ecs-named-service-check.json ecs-$line-service-check.json
	sed -i '' "s/foo/$aws_cluster/;s/bar/$line/" ecs-$line-service-check.json
    	echo "Done for service: $line"
done < services.txt
rm services.txt
