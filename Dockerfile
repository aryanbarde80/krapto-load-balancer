FROM nginx:alpine

# Install nginx upstream check module
RUN apk add --no-cache nginx-mod-http-upstream-check

# Remove default configs
RUN rm -rf /etc/nginx/conf.d/*

# Copy configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy static files
COPY index.html /usr/share/nginx/html/
COPY 50x.html /usr/share/nginx/html/  # Error page

# Create nginx cache directory
RUN mkdir -p /var/cache/nginx /var/log/nginx
RUN chown -R nginx:nginx /var/cache/nginx /var/log/nginx
RUN chmod -R 755 /var/log/nginx

# Expose ports
EXPOSE 80
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q --spider http://localhost/health || exit 1

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
