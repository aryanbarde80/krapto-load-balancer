# Use official nginx alpine image
FROM nginx:1.24-alpine

# Install envsubst for template processing
RUN apk add --no-cache gettext bash

# Remove default nginx configs
RUN rm -rf /etc/nginx/conf.d/*

# Copy nginx template configuration
COPY nginx.conf.template /etc/nginx/templates/nginx.conf.template

# Set proper permissions
RUN chown -R nginx:nginx /var/cache/nginx && \
    chmod -R 755 /var/cache/nginx

# Health check script (simple version)
RUN echo '#!/bin/sh' > /usr/local/bin/health-check.sh && \
    echo 'wget --quiet --tries=1 --spider http://localhost:${PORT:-80}/health || exit 1' >> /usr/local/bin/health-check.sh && \
    chmod +x /usr/local/bin/health-check.sh

# Expose port
EXPOSE 80

# Use default nginx entrypoint (already handles templates)