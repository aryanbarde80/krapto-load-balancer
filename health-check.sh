#!/bin/sh
# Simple health check script for Docker

# Check if nginx is running
if ! pgrep nginx > /dev/null; then
    echo "nginx is not running"
    exit 1
fi

# Check if nginx can serve requests
if curl -f http://localhost/health > /dev/null 2>&1; then
    echo "Health check passed"
    exit 0
else
    echo "Health check failed"
    exit 1
fi