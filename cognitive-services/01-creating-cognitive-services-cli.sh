#!/bin/bash

# Global variables
rg={resource group name}
location={location}
facename={face api name}
textanalyticsname={text analytics name}
computervisionname={computer vision name}
bingsearchname={bing search name}
bingautosuggestname={bing auto suggest name}

# Creating a new resource group for Cognitive Services
az group create \
    -n $rg \
    -l $location

# Creating Face Recognition service
az cognitiveservices account create \
    -n $facename \
    -g $rg \
    --kind Face \
    --sku S0 \
    -l $location \
    --yes

# Creating Text Analysis service
az cognitiveservices account create \
    -n $textanalyticsname \
    -g $rg \
    --kind TextAnalytics \
    --sku F0 \
    -l $location \
    --yes

# Creating Emotions account
az cognitiveservices account create \
    -n $computervisionname \
    -g $rg \
    --kind ComputerVision \
    --sku F0 \
    -l $location \
    --yes

# Creating Bing Search account
az cognitiveservices account create \
    -n $bingsearchname \
    -g $rg \
    --kind Bing.Search.v7 \
    --sku F0 \
    -l global \
    --yes

# Creating Bing Autosuggest account
az cognitiveservices account create \
    -n $bingautosuggestname \
    -g $rg \
    --kind Bing.Autosuggest.v7 \
    --sku F0 \
    -l global \
    --yes

# Getting values from created apis
echo "------------------------------------------------------------------------------"
echo "-                            KEYS                                            -"
echo "------------------------------------------------------------------------------"

facekey=$(az cognitiveservices account keys list -n $facename -g $rg --query "key1")
echo Face API Key: $facekey

echo "----------"

textanalyticskey=$(az cognitiveservices account keys list -n $textanalyticsname -g $rg --query "key1")
echo Text Analytics Key: $textanalyticskey

echo "----------"

computervisionkey=$(az cognitiveservices account keys list -n $computervisionname -g $rg --query "key1")
echo Computer Vision Key: $computervisionkey

echo "----------"

bingsearchkey=$(az cognitiveservices account keys list -n $bingsearchname -g $rg --query "key1")
echo Bing Search Key: $bingsearchkey

echo "----------"

bingautosuggestkey=$(az cognitiveservices account keys list -n $bingautosuggestname -g $rg --query "key1")
echo Bing Autosuggest Key: $bingautosuggestkey
