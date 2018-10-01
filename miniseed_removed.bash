#!/bin/bash

# uses https://github.com/andreafabrizi/Dropbox-Uploader

FILEPATH=$1
FILENAME=${1##*/}
COMMAND="dropbox_uploader.sh delete mini_logger_writer/${FILENAME}"
echo "$0: COMMAND= ${COMMAND}"
${COMMAND}
