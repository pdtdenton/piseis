#!/bin/sh

WORKING_DIR=.

if [ ! -e "${WORKING_DIR}/log" ]; then
	mkdir ${WORKING_DIR}/log
fi

# stop logger and writer
./stop_logger_writer.sh

# start logger and writer
echo "Starting mini_logger_writer..."
LOGFILE=${WORKING_DIR}/log/mini_logger_writer.log
nohup ./mini_logger_writer -v 1> ${LOGFILE} 2>&1 &
PID=$!
echo ${PID} > ${WORKING_DIR}/log/mini_logger_writer.pid
echo "   mini_logger_writer pid=${PID}, logfile=${LOGFILE}"
sleep 1
