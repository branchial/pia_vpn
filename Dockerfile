FROM alpine:3.16 as base
RUN apk update
RUN apk add --upgrade apk-tools
RUN apk upgrade --available
RUN apk add curl jq openvpn bash
WORKDIR /opt

FROM base as builder
RUN apk add git
RUN git clone https://github.com/pia-foss/manual-connections.git pia

FROM base
RUN mkdir -p /opt/pia
RUN mkdir -p /opt/pia/openvpn_config
WORKDIR /opt/pia

COPY --from=builder /opt/pia/*.sh /opt/pia/
COPY --from=builder /opt/pia/*.crt /opt/pia/
COPY --from=builder /opt/pia/openvpn_config/. /opt/pia/openvpn_config/
COPY entrypoint.sh /opt/entrypoint.sh
RUN ["chmod", "+x", "/opt/entrypoint.sh"]

ENTRYPOINT ["/opt/entrypoint.sh"]