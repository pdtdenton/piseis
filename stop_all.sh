#!/bin/sh

HOME=./

# announce script
echo "Stopping processes:"

./stop_logger_writer.sh
./stop_ringserver.sh

echo "All processes stopped."
echo ""
exit 1

