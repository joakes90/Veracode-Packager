#!/bin/bash
ARCHIVES_DIR=~/Library/Developer/Xcode/Archives/
ARCHIVE_GROUPS=$(ls $ARCHIVES_DIR | sort -r)
GROUPS_ARRAY=($ARCHIVE_GROUPS)
cd $ARCHIVES_DIR${GROUPS_ARRAY[0]}
ARCHIVES_ARRAY=$(ls | sort -r)
NEWARCHIVE=${ARCHIVES_ARRAY[0]}
PACKAGED_ARCHIVES=$(ls | sort -r)
ARCHIVE=${PACKAGED_ARCHIVES[0]}
cd "$ARCHIVE"
mv Products/Applications ./Payload
rm -r Products
zip -r LovesConnect.bca ./*
## Upload LovesConnect.bca to vericode
curl -o veracode-wrapper.jar https://repo1.maven.org/maven2/com/veracode/vosp/api/wrappers/vosp-api-wrappers-java/19.3.5.7/vosp-api-wrappers-java-19.3.5.7.jar
java -jar veracode-wrapper.jar -action uploadandscan -vid b6a1af53e81028c9e854d0f7636a51cc -vkey 4ef0ff8fe7cfa53f828398b80952625bab31e6c910921fc32949834a405520a4b5ed215ebd587a8186d4d562366cb117892832bd1f2745452c2f452739aa375a -appid 371192 -appname "iOS App" -createprofile false -version ‘Automated Static’ -filepath ./LovesConnect.bca

# curl --compressed -u justin.oakes@loves.com:sykkaq-Piwcoz-0soxmu https://analysiscenter.veracode.com/api/5.0/uploadfile.do -F "app_id=371192" -F "file=LovesConnect.bca" -F "save_as=LovesConnect.bca"
