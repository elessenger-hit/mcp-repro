#!/bin/bash
set -e

# Load environment variables from .env file if it exists
if [ -f .env ]; then
    echo "Loading environment variables from .env file..."
    set -a
    . ./.env
    set +a
    echo "Environment variables loaded successfully"
else
    echo "No .env file found, using existing environment variables"
fi

# Execute the command passed to the container
uvicorn main:asgi --host 0.0.0.0 --port 8000 --workers 1