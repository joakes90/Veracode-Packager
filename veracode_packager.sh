#!/bin/bash

## Setting environment vars
VERACODE_ID="Enter_Veracode_ID_Here"
VERACODE_KEY="Veracode_Key"
APP_ID="Veracode_App_ID"
APP_NAME="Veracode_App_Name"
FILE_PATH="Path_To_Save_File"

## Locating the latest Xcode archive
ARCHIVES_DIR=~/Library/Developer/Xcode/Archives/
ARCHIVE_GROUPS=$(ls $ARCHIVES_DIR | sort -r)
GROUPS_ARRAY=($ARCHIVE_GROUPS)
cd $ARCHIVES_DIR${GROUPS_ARRAY[0]}
ARCHIVES_ARRAY=$(ls | sort -r)
NEWARCHIVE=${ARCHIVES_ARRAY[0]}
PACKAGED_ARCHIVES=$(ls | sort -r)
ARCHIVE=${PACKAGED_ARCHIVES[0]}
cd "$ARCHIVE"

## Creating the Veracode Bitcode archive
mv Products/Applications ./Payload
rm -r Products
zip -r $FILE_PATH ./*

## Upload LovesConnect.bca to Veracode
curl -o veracode-wrapper.jar https://repo1.maven.org/maven2/com/veracode/vosp/api/wrappers/vosp-api-wrappers-java/19.3.5.7/vosp-api-wrappers-java-19.3.5.7.jar
java -jar veracode-wrapper.jar -action uploadandscan -vid $VERACODE_ID -vkey $VERACODE_KEY -appid $APP_ID -appname $APP_NAME -autoscan true -platform iOS -createprofile false -version $(date "+%Y%m%d%H%M%S") -filepath $FILE_PATH

