.PHONY: help build run stop clean logs restart status vnc-password

# Variables
CONTAINER_NAME = brave-container
IMAGE_NAME = brave-browser
VNC_PASSWORD ?= vncpass123

help:
	@echo "Available commands:"
	@echo "  make build         - Build the Docker image"
	@echo "  make run          - Run the container"
	@echo "  make stop         - Stop the container"
	@echo "  make clean        - Remove container and image"
	@echo "  make logs         - View container logs"
	@echo "  make restart      - Restart the container"
	@echo "  make status       - Check container status"
	@echo "  make vnc-password - Change VNC password (use VNC_PASSWORD=your_new_password)"
	@echo ""
	@echo "Access Instructions:"
	@echo "  VNC Client: localhost:5900 (password: $(VNC_PASSWORD))"
	@echo "  Browser: http://localhost:6080"

build:
	@echo "Building Docker image..."
	docker build --build-arg VNC_PASSWORD=$(VNC_PASSWORD) -t $(IMAGE_NAME) .

run:
	@echo "Starting container..."
	docker run -d \
		--name $(CONTAINER_NAME) \
		-p 5900:5900 \
		-p 6080:6080 \
		-e VNC_PASSWORD=$(VNC_PASSWORD) \
		$(IMAGE_NAME)
	@echo "Container started!"
	@echo "Access via:"
	@echo "  - VNC Client: localhost:5900 (password: $(VNC_PASSWORD))"
	@echo "  - Browser: http://localhost:6080"

stop:
	@echo "Stopping container..."
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true

clean: stop
	@echo "Removing image..."
	docker rmi $(IMAGE_NAME) || true

logs:
	docker logs -f $(CONTAINER_NAME)

restart: stop run

status:
	@echo "Container Status:"
	@docker ps -a | grep $(CONTAINER_NAME) || echo "Container not found"
	@echo "\nPorts:"
	@docker port $(CONTAINER_NAME) 2>/dev/null || echo "No active ports"

vnc-password:
	@echo "Changing VNC password..."
	@docker exec -it $(CONTAINER_NAME) \
		x11vnc -storepasswd $(VNC_PASSWORD) /root/.vnc/passwd
	@echo "VNC password updated to: $(VNC_PASSWORD)"

# Usage example target
example:
	@echo "Example commands:"
	@echo "1. Build and run:"
	@echo "   make build"
	@echo "   make run"
	@echo ""
	@echo "2. Change VNC password:"
	@echo "   make vnc-password VNC_PASSWORD=new_password"