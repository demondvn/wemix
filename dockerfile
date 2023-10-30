# Use a base image with Go support, for example, the official Go image
FROM golang:latest

# Set the working directory
WORKDIR /wemix

# Copy the binary and configuration files into the image
COPY bin/ ./bin/
COPY conf/ ./conf/
COPY .rc/ .

# Make the startup script executable
RUN chmod +x bin/gwemix.sh

# Install required packages (libsnappy-dev and libjemalloc-dev)
RUN apt-get update && apt-get install -y libsnappy-dev libjemalloc-dev

# Create a symbolic link for libjemalloc.so.1
RUN ln -s /usr/lib/x86_64-linux-gnu/libjemalloc.so.2 /usr/lib/x86_64-linux-gnu/libjemalloc.so.1

# Expose the necessary ports
EXPOSE 8589
EXPOSE 8588
EXPOSE 8598

# Define the command to start the application
CMD ["/bin/bash", "-c", "/wemix/bin/gwemix.sh start & tail -F /wemix/logs/log"]
