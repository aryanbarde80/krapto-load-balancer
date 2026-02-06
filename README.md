# 🔄 Krapto Load Balancer

A lightweight and efficient load balancer for **Krapto Technologies Private Limited** to distribute traffic across multiple Node.js servers.

## ✨ Features

- ✅ **Round-robin load balancing**
- ✅ **Health checks** for backend servers
- ✅ **Docker containerized** deployment
- ✅ **Easy configuration** with environment variables
- ✅ **WebSocket support** for real-time applications
- ✅ **Rate limiting** protection

## 🚀 Quick Start

### 1. Clone Repository
```bash
git clone https://github.com/aryanbarde80/krapto-load-balancer.git
cd krapto-load-balancer
```

### 2. Configure Backend Servers
Edit `nginx.conf` and update your Node.js server IPs:

```nginx
upstream backend {
    server 192.168.1.10:3000;  # Your first Node.js server
    server 192.168.1.11:3000;  # Your second Node.js server
    server 192.168.1.12:3000;  # Your third Node.js server
}
```

### 3. Deploy with Docker
```bash
# Build the image
docker build -t krapto-lb .

# Run the load balancer
docker run -d -p 80:80 --name krapto-load-balancer krapto-lb
```

## 📁 File Structure

```
📦 krapto-load-balancer
├── 📄 Dockerfile      # Docker configuration
├── 📄 nginx.conf     # NGINX load balancer config
└── 📄 README.md      # This documentation
```

## 🐳 Docker Commands

| Command | Description |
|---------|-------------|
| `docker build -t krapto-lb .` | Build the image |
| `docker run -d -p 80:80 krapto-lb` | Run container |
| `docker logs krapto-lb` | View logs |
| `docker stop krapto-lb` | Stop container |
| `docker start krapto-lb` | Start container |

## ⚙️ Configuration Options

### Basic Configuration
Update these values in `nginx.conf`:

```nginx
server {
    listen 80;                          # Port to listen on
    server_name your-domain.com;        # Your domain
    
    location / {
        proxy_pass http://backend;      # Backend servers
        proxy_set_header Host $host;    # Preserve host header
    }
}
```

### Environment Variables
Set these when running Docker:

```bash
docker run -d \
  -p 80:80 \
  -e BACKEND_SERVERS="server1:3000,server2:3000" \
  krapto-lb
```

## 🔍 Monitoring

### Check Health Status
```bash
curl http://localhost/health
```
**Response:** `healthy` ✅

### View Access Logs
```bash
docker logs krapto-lb
```

## 📊 Load Balancing Methods

| Method | Description | Use Case |
|--------|-------------|----------|
| **Round Robin** | Distributes requests sequentially | Default, general purpose |
| **Least Connections** | Sends to server with fewest connections | Long-running connections |
| **IP Hash** | Same client → same server | Session persistence |

## 🛡️ Security Features

- **Rate limiting** to prevent abuse
- **Request timeouts** to handle slow backends
- **Connection limits** per server
- **Health checks** to remove failed servers

## 🔄 Update Process

1. **Update configuration** in `nginx.conf`
2. **Rebuild Docker image**:
   ```bash
   docker build -t krapto-lb:v2 .
   ```
3. **Deploy new version**:
   ```bash
   docker stop krapto-lb
   docker run -d -p 80:80 --name krapto-lb-v2 krapto-lb:v2
   ```

## 🚨 Troubleshooting

| Issue | Solution |
|-------|----------|
| ❌ "502 Bad Gateway" | Check backend servers are running |
| ❌ "Connection refused" | Verify backend IPs/ports |
| ❌ High response time | Adjust proxy timeouts in config |
| ❌ Container won't start | Check Docker logs for errors |

## 📞 Support

For issues or questions:
- **GitHub Issues:** [Create Issue](https://github.com/aryanbarde80/krapto-load-balancer/issues)
- **Email:** support@kraptotechnologies.com

---

**Maintained by:** Krapto Technologies Private Limited  
**Version:** 1.0.0  
**Last Updated:** February 2025

---

⭐ **Star this repo** if you found it useful!
