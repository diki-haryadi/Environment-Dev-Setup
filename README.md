# Development Environment Setup

A containerized development environment setup featuring Brave Browser with VNC access, perfect for remote development and testing.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/Docker-Supported-blue.svg)](https://www.docker.com/)

## 🚀 Features

- Dockerized Brave Browser setup
- VNC server for remote access
- noVNC for browser-based access
- Supervisor process management
- Fluxbox window manager
- Easy configuration and customization
- Cross-platform compatibility

## 📋 Prerequisites

- Docker installed on your system
- Docker Compose (optional but recommended)
- VNC Viewer (optional for VNC access)

## 🛠️ Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/dev-environment-setup.git
cd dev-environment-setup
```

2. Build and run using Docker Compose:
```bash
docker-compose up -d --build
```

Or using Docker directly:
```bash
docker build -t brave-browser .
docker run -d -p 5900:5900 -p 6080:6080 --name brave-container brave-browser
```

## 🔗 Accessing the Environment

### Via Web Browser (noVNC)
- Open your browser and navigate to: `http://localhost:6080`
- No additional software required

### Via VNC Client
- Connect to: `localhost:5900`
- Default password: `vncpass123`

## 🔧 Configuration

### Customizing VNC Password
Edit the `docker-compose.yml` file:
```yaml
environment:
  - VNC_PASSWORD=your_new_password
```

### Modifying Screen Resolution
Edit the `supervisord.conf` file:
```ini
[program:xvfb]
command=/usr/bin/Xvfb :99 -screen 0 1920x1080x24
```

## 📦 Project Structure

```
.
├── Dockerfile
├── docker-compose.yml
├── supervisord.conf
└── README.md
```

## 🪄 Usage Examples

1. Running with persistent storage:
```bash
docker run -d \
  -p 5900:5900 \
  -p 6080:6080 \
  -v /path/to/downloads:/root/Downloads \
  brave-browser
```

2. Running with custom resolution:
```bash
docker run -d \
  -p 5900:5900 \
  -p 6080:6080 \
  -e DISPLAY_WIDTH=1600 \
  -e DISPLAY_HEIGHT=900 \
  brave-browser
```

## 🔍 Troubleshooting

### Common Issues

1. VNC Connection Failed
```bash
# Check if container is running
docker ps

# Check container logs
docker logs brave-container
```

2. Port Conflicts
```bash
# Check if ports are in use
lsof -i :5900
lsof -i :6080
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Brave Browser](https://brave.com/)
- [noVNC](https://novnc.com/)
- [Docker](https://www.docker.com/)
- [Supervisor](http://supervisord.org/)

## 📞 Support

For support, please open an issue in the GitHub repository or contact the maintainers.

## 🔄 Updates and Maintenance

This project is actively maintained. Please check the releases page for updates.

---

Made with
