# Use Python 3.9 slim-bullseye for compatibility and a lightweight image
FROM python:3.9-slim-bullseye  

# Set environment variables for cleaner logs and non-buffered output
ENV PYTHONUNBUFFERED=1

# Install necessary dependencies for computer vision
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    ffmpeg \
    libsm6 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip to a stable 2023 version
RUN pip install --upgrade pip==23.1.2  

# Set working directory before copying files
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Default command (modify as needed)
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]