#!/bin/bash

HOME_DIR=$(pwd $basename $0)
OUT_DIR=$HOME_DIR/out
# https://api.slack.com/tutorials/slack-apps-hello-world
# Follow this instruction to get WEBHOOK_URL
WEBHOOK_URL=WEBHOOK_URL

curl --compressed -Ls https://github.com/labbots/google-drive-upload/raw/master/install.sh | sh -s

mkdir $OUT_DIR

# Create dummy files
touch $OUT_DIR/sample-1.tsv
touch $OUT_DIR/sample-2.tsv

touch output.txt

# Folder format in date
gupload $OUT_DIR | tee output.txt


upload_link=$(egrep -o 'https://drive.google.com?[^ ]+' output.txt)


# Share drive link intto Slack channel
curl -X POST -H 'Content-type: application/json' --data '{"text":"'"Log files uploaded! \n Link: $upload_link"'"}' $WEBHOOK_URL
echo ""

# remove output.txt
rm -rf $OUT_DIR
