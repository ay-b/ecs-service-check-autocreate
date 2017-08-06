# Autocreate Sensu's json check files

## Requirements

aws cli

## Usage
* Be sure you authorised with desired credentials at aws and configured default zone
* Edit template json-file with desired settings
* Launch the script

Single cluster script will ask for cluster name and region.
Multi cluster will do everything automatically — files will be created for every service in every cluster found.

As a result you'll get the multiple files named with [cluster_name]-[service_name]-service-check.json names in the current folder. 

Later I'll probably release other scripts for automated check collection creation.
