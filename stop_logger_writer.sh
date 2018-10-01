#!/bin/sh

HOME=./

# announce script
echo "Stopping mini_logger_writer:"

# stop logger and writer
if [ -f "${HOME}/log/mini_logger_writer.pid" ] ; then
    pid=`cat ${HOME}/log/mini_logger_writer.pid`
    echo "Stopping mini_logger_writer [$pid]..."
    kill $pid
    rm -f ${HOME}/log/mini_logger_writer.pid
fi
sleep 1

echo "mini_logger_writer stopped."
echo ""
exit 1

