FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV VNC_PASSWORD=vncpass123

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    wget \
    xvfb \
    x11vnc \
    xterm \
    fluxbox \
    novnc \
    websockify \
    supervisor \
    net-tools \
    python3 \
    python3-numpy \
    && rm -rf /var/lib/apt/lists/*

# Install Brave browser
RUN curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list \
    && apt-get update \
    && apt-get install -y brave-browser \
    && rm -rf /var/lib/apt/lists/*

# Setup VNC password
RUN mkdir -p /root/.vnc && \
    x11vnc -storepasswd ${VNC_PASSWORD} /root/.vnc/passwd

# Configure noVNC with proper symlink handling
RUN mkdir -p /usr/local/share/novnc && \
    rm -f /usr/share/novnc/index.html && \
    ln -sf /usr/share/novnc/vnc.html /usr/share/novnc/index.html && \
    chmod -R 755 /usr/share/novnc && \
    chown -R root:root /usr/share/novnc

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Create startup script
RUN echo '#!/bin/bash\n\
websockify --web=/usr/share/novnc 6080 localhost:5900 &\n\
exec "$@"' > /startup.sh && \
    chmod +x /startup.sh

EXPOSE 5900 6080

ENTRYPOINT ["/startup.sh"]
CMD ["/usr/bin/supervisord"]