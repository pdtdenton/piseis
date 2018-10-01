#!/bin/bash


FILEPATH_WRITE=$1
FILENAME_WRITE=${1##*/}

FILEPATH_REMOVE=$2
FILENAME_REMOVE=${2##*/}

# use https://github.com/andreafabrizi/Dropbox-Uploader
#COMMAND="dropbox_uploader.sh upload ${FILEPATH_WRITE} mini_logger_writer/${FILENAME_WRITE}"
#echo "$0: COMMAND= ${COMMAND}"
#${COMMAND}

# use curl to do an ftp upload of argument FILEPATH_WRITE to an ftp server and simultaneously remove FILEPATH_REMOVE
#
# NOTE: for minimal security, the curl --netrc option is used:
# -n, --netrc
# Makes curl scan the .netrc (_netrc on Windows) file in the user's home directory for login name and password. This is typically used for FTP on UNIX. If used with HTTP, curl will enable user authentication. See netrc(4) or ftp(1) for details on the file format. Curl will not complain if that file doesn't have the right permissions (it should not be either world- or group-readable). The environment variable "HOME" is used to find the home directory.
# A quick and very simple example of how to setup a .netrc to allow curl to FTP to the machine host.domain.com with user name 'myself' and password 'secret' should look similar to:
# machine host.domain.com login myself password secret 
#
FTP_HOST="ftp://alomax.free.fr"
FTP_DIR="/temp/mini_logger_writer"
COMMAND="curl -T ${FILEPATH_WRITE} --netrc ${FTP_HOST}${FTP_DIR}/${FILENAME_WRITE} -Q \"-DELE ${FTP_DIR}/${FILENAME_REMOVE}\""
echo "$0: COMMAND= ${COMMAND}"
# NOTE: curl command does not run correctly using ${COMMAND}, so re-write command:
curl -T ${FILEPATH_WRITE} --netrc ${FTP_HOST}${FTP_DIR}/${FILENAME_WRITE} -Q "-DELE ${FTP_DIR}/${FILENAME_REMOVE}"

#DEBUG - for testing, use curl to download written file to local ringserver dir
COMMAND="curl -o ../temp/data_current/${FILENAME_WRITE} http://alomax.free.fr/temp/mini_logger_writer/${FILENAME_WRITE}"
echo "$0: COMMAND= ${COMMAND}"
${COMMAND}
COMMAND="rm ../temp/data_current/${FILENAME_REMOVE}"
echo "$0: COMMAND= ${COMMAND}"
${COMMAND}
