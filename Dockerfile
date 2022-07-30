FROM alpine:3.16 as base
RUN apk update
RUN apk add --upgrade apk-tools
RUN apk upgrade --available
RUN apk add curl jq openvpn
WORKDIR /opt/

FROM base as builder
RUN apk add git
RUN git clone https://github.com/pia-foss/manual-connections.git pia

FROM base
COPY --from=builder /opt/pia/*.sh /opt/pia/
COPY --from=builder /opt/pia/*.crt /opt/pia/
COPY --from=builder /opt/pia/openvpn_config /opt/pia/openvpn_config
COPY entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]