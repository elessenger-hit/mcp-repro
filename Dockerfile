# Use Python 3.12 slim image as base
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies (including bash for the entrypoint script)
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY ./src/*.py ./

# Copy entrypoint script and make it executable
COPY docker-entrypoint.sh ./
RUN chmod +x ./docker-entrypoint.sh

# Copy .env file if it exists (for local development)
# In production, use environment variables or secrets
COPY .env* ./

# Expose port 8000
EXPOSE 8000

# Set environment variables for uvicorn
ENV PYTHONUNBUFFERED=1
ENV HOST=0.0.0.0
ENV PORT=8000

# Use the entrypoint script to load .env file before running the application
# ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["/app/docker-entrypoint.sh"]