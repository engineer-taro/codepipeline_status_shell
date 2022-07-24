#!/bin/bash

pipeline_name="$1"
profile="$2"
region="$3"

if [ -z $pipeline_name ]; then
	echo 'Pass the pipeline name as an argument.'
	exit 1
fi
get_pipeline_state_result=$(aws codepipeline get-pipeline-state \
	--name $pipeline_name \
	${profile:+--profile "${profile}"} \
	${region:+--region "${region}"})
jq_status=$(echo $get_pipeline_state_result | \
	jq '.stageStates | map({stageName: .stageName, status: .latestExecution.status })')

echo $jq_status | jq '.'


