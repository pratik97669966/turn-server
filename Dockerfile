FROM debian:bullseye

# Install CoTURN
RUN apt-get update && apt-get install -y coturn && apt-get clean

# Copy configuration file
COPY turnserver.conf /etc/turnserver.conf

# Expose TURN/STUN ports
EXPOSE 3478/udp
EXPOSE 3478/tcp
EXPOSE 5349/tcp
EXPOSE 49152-65535/udp

# Start the TURN server
CMD ["turnserver", "-c", "/etc/turnserver.conf", "--no-cli", "--daemon"]
