#!/bin/bash


MSWRITE_DIR=/Users/anthony/Dropbox/mini_logger_writer/data_current
declare -i MAX_FILE_AGE=30*60 	#30min


#SLEEP_INTERVAL=60	#sec
SLEEP_INTERVAL=10	#sec


function check_dir {
	DIR_TIME=$(stat -f "%m" ${TARGET_DIR})
	echo "${DIR_TIME} ${TARGET_DIR}"
	DIFF_TIME=LAST_UPDATE-DIR_TIME
	echo "DIFF_TIME ${DIFF_TIME}"
	if [ ${DIFF_TIME} -gt ${MAX_FILE_AGE} ]; then
		echo "DELETE! dropbox_uploader.sh delete ${TARGET_DIR}"
	fi
	if [ ${DIR_TIME} -ge ${LAST_UPDATE} ]; then
		echo "UPLOAD! dropbox_uploader.sh upload ${TARGET_DIR}"
	fi
}



declare -i LAST_UPDATE=$(date +%s)
echo "LAST_UPDATE=${LAST_UPDATE=}"

declare -i DIR_TIME=0
declare -i DIFF_TIME=0

while true; do

	echo "$0 processing...  ========================================================"

	for YEAR_DIR in ${MSWRITE_DIR}/* ; do
		TARGET_DIR=${YEAR_DIR}
		check_dir
		for MONTH_DIR in ${YEAR_DIR}/* ; do
			TARGET_DIR=${MONTH_DIR}
			check_dir
			for DAY_DIR in ${MONTH_DIR}/* ; do
				TARGET_DIR=${DAY_DIR}
				check_dir
				for HOUR_DIR in ${DAY_DIR}/* ; do
					TARGET_DIR=${HOUR_DIR}
					check_dir
					for MIN_DIR in ${HOUR_DIR}/* ; do
						TARGET_DIR=${MIN_DIR}
						check_dir
					done
				done
			done
		done
	done

sleep ${SLEEP_INTERVAL}
LAST_UPDATE=$(date +%s)
done





#  523  dropbox_uploader.sh upload data_current/2013/12/16/13 data_current/2013/12/16/13
