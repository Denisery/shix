# Use Ubuntu as the base image
FROM ubuntu:latest

# Set non-interactive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Set working directory
WORKDIR /app

# Update and install essential packages
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    software-properties-common \
    python3 \
    python3-pip \
    nodejs \
    npm && \
    # Install the latest Node.js
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    # Clean up
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Download the file
RUN wget https://s3.amazonaws.com/sshx/sshx-x86_64-unknown-linux-musl.tar.gz

# Extract the tar.gz archive
RUN tar -xzvf sshx-x86_64-unknown-linux-musl.tar.gz

# Set permissions for the extracted binary
RUN chmod +x sshx

# Copy Flask application files
COPY app.py /app/
COPY requirements.txt /app/

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Expose Flask server port and any required ports for sshx
EXPOSE 22 8000

# Run both sshx and Flask server
CMD ["sh", "-c", "./sshx & python3 app.py"]
