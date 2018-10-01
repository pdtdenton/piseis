#!/bin/sh

echo "Usage: $0 STREAMS [WINDOW_LENGTH [HOST_NAME [PORT]]]"
	echo "   STREAMS - streams to display in NET_STA format"
	echo "     for example: UK_*:BHZ IU_KONO:BHE BHN,GE_WLF,MN_AQU:HH?.D"
	echo "     (use quotes \"...\" around the whole STREAMS parameter when blanks, * or ? are present)"
	echo "   WINDOW_LENGTH - SG2K display window length in seconds [default=3600s]"
	echo "   HOST_NAME - SeedLink host name [default=localhost]"
	echo "   PORT - SeedLink port [default=18000]"

if [ -n "$1" ]; then
	if [ $1 = "-h" ]; then
		exit 0
	fi
fi

STREAMS=$1

WINDOW_LENGTH=$2
if [ -z "${WINDOW_LENGTH}" ]; then
	WINDOW_LENGTH=3600
fi
echo "WINDOW_LENGTH=${WINDOW_LENGTH}"

HOST_NAME=$3
if [ -z "${HOST_NAME}" ]; then
	HOST_NAME=localhost
fi
echo "HOST_NAME=${HOST_NAME}"

PORT=$4
if [ -z "${PORT}" ]; then
	PORT=18000
fi
echo "PORT=${PORT}"


COMMAND="nice java -Xmx768m -jar SeisGram2K60.jar -seedlink ${HOST_NAME}:${PORT}#${STREAMS}#${WINDOW_LENGTH} -seedlink.groupchannels=YES -display.maxvisible=12 -display.font=1.5,BOLD -display.sort.type=NONE -display.analysistoolbar=NO -seedlink.backfill=YES -display.align=REALTIME -seedlink.clocktype=SEEDLINK_INFO -realtime.update=1 -display.beep.error=NO -debug 99"
echo ${COMMAND}
echo
${COMMAND}


