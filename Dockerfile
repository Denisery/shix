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
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    # Clean up
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Download the file
RUN wget https://s3.amazonaws.com/sshx/sshx-x86_64-unknown-linux-musl.tar.gz

# Extract the file
RUN tar -xzvf sshx-x86_64-unknown-linux-musl.tar.gz

# Expose required ports (modify based on sshx requirements)
EXPOSE 22

# Set permissions for the extracted binary (optional)
RUN chmod +x sshx

# Verify installations
RUN node -v && npm -v && python3 --version && pip3 --version

# Set the entry point to run sshx
CMD ["./sshx"]
