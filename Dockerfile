FROM alpine:3.16 as base
RUN apk update
RUN apk add --upgrade apk-tools
RUN apk upgrade --available
RUN apk add curl jq openvpn findutils
WORKDIR /opt

ADD piavpn-manual /opt/piavpn-manual
RUN find piavpn-manual/ -type f -iname '*.sh*' -exec chmod +x {} \;

COPY entrypoint.sh /opt/entrypoint.sh
RUN ["chmod", "+x", "entrypoint.sh"]

ENTRYPOINT ["/opt/entrypoint.sh"]