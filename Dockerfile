FROM nginx:alpine

# Remove default configs
RUN rm -rf /etc/nginx/conf.d/*

# Create HTML directory
RUN mkdir -p /usr/share/nginx/html

# Copy configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy static files
COPY index.html /usr/share/nginx/html/

# Create nginx cache directory
RUN mkdir -p /var/cache/nginx /var/log/nginx
RUN chown -R nginx:nginx /var/cache/nginx /var/log/nginx

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q --spider http://localhost/health || exit 1

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
