# mcp-repro

This codebase reliably fails when executed from within the provided devcontainer.

1. The devcontainer is my unmodified version
2. The main.py file is based on my original, but has been significantly reduced
3. The env file has been nerfed for security, but the error messages are identical
4. The requirements.txt file is my unmodified version

## Docker

This command should build correctly and then fail after the environment variables are applied.

```bash

docker run

```

## Command-line

This command should fail very quickly.

```bash

set -a && .env && set +a
cd src
uvicorn main:asgi --host 0.0.0.0 --port 8000 --workers 1

```