# Use a lightweight base image
FROM alpine:latest

# Set working directory
WORKDIR /app

# Install required tools (wget and tar)
RUN apk add --no-cache wget tar

# Download the file
RUN wget https://s3.amazonaws.com/sshx/sshx-x86_64-unknown-linux-musl.tar.gz

# Extract the file
RUN tar -xzvf sshx-x86_64-unknown-linux-musl.tar.gz

# Expose required ports (modify based on the program's needs)
EXPOSE 22

# Set the entry point
CMD ["./sshx"]
