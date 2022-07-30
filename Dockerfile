FROM alpine:3.16 as base
RUN apk update
RUN apk add --upgrade apk-tools
RUN apk upgrade --available
RUN apk add curl jq openvpn
WORKDIR /opt

ADD piavpn-manual /opt/piavpn-manual
RUN ["chmod", "u+x", "piavpn-manual/**/*.sh"]
RUN ["chmod", "u+x", "piavpn-manual/openvpn_config/**/*.sh"]

COPY entrypoint.sh /opt/entrypoint.sh
RUN ["chmod", "+x", "entrypoint.sh"]

ENTRYPOINT ["/opt/entrypoint.sh"]