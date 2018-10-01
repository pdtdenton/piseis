#!/bin/sh

# announce script
echo "Starting processes:"
sleep 1

./start_logger_writer.sh
./start_ringserver.sh

echo "All processes started."
echo ""
exit 1

