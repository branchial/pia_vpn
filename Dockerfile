FROM alpine:3.16 as base
RUN apk update
RUN apk add --upgrade apk-tools
RUN apk upgrade --available
RUN apk add curl jq openvpn findutils bash
WORKDIR /opt/piavpn-manual

ADD piavpn-manual /opt/piavpn-manual
COPY entrypoint.sh /opt/entrypoint.sh

# make scripts executable
RUN find /opt/ -type f -iname '*.sh*' -exec chmod +x {} \;
RUN find /opt/piavpn-manual/ -type f -iname '*.sh*' -exec chmod +x {} \;
RUN find /opt/piavpn-manual/openvpn_config/ -type f -iname '*.sh*' -exec chmod +x {} \;

ENTRYPOINT ["/opt/entrypoint.sh"]