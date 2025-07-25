#!/bin/bash

if [[ $CKAN__PLUGINS == *"datapusher"* ]]; then
   # Datapusher settings have been configured in the .env file
   # Set API token if necessary
   if [ -z "$CKAN__DATAPUSHER__API_TOKEN" ] ; then
      echo "Set up ckan.datapusher.api_token in the CKAN config file"
      ckan config-tool $CKAN_INI "ckan.datapusher.api_token=$(ckan -c $CKAN_INI user token add ckan_admin datapusher | tail -n 1 | tr -d '\t')"
   fi
else
   echo "Not configuring DataPusher"
fi
echo "data pusher plus stuff 2"
#data pusher plus config
ckan config-tool $CKAN_INI "scheming.dataset_fallback = true"
ckan config-tool $CKAN_INI "scheming.presets = ckanext.scheming:presets.json"
ckan config-tool $CKAN_INI "scheming.dataset_schemas = ckanext.datapusher_plus:dataset-druf.yaml"
ckan config-tool $CKAN_INI "ckan.datastore.write_url = $CKAN_DATASTORE_WRITE_URL"