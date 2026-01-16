FROM docker:latest

WORKDIR /app

# Copy React Nginx Dockerfile template
COPY Dockerfile.react Dockerfile

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]