FROM ubuntu:22.04

RUN apt update
RUN apt install coturn -y

# Modify default configuration for CoTURN
RUN sed -i "s/USER=turnserver/USER=root/" /etc/init.d/coturn
RUN sed -i "s/GROUP=turnserver/GROUP=root/" /etc/init.d/coturn
RUN sed -i "s/#TURNSERVER_ENABLED=1/TURNSERVER_ENABLED=1/" /etc/default/coturn

# Stop CoTURN service to avoid conflicts
RUN service coturn stop

# Expose TURN/STUN ports
EXPOSE 3478/udp
EXPOSE 3478/tcp
EXPOSE 5349/tcp
EXPOSE 49152-65535/udp

# Start CoTURN service
CMD service coturn start && tail -f /dev/null
