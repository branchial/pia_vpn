#!/usr/bin/env ash

docker run --rm -i --cap-add NET_ADMIN --device /dev/net/tun -e "REGION=france" -v $(pwd)/.credentials:/etc/openvpn/pia/pass ezjos/piavpn
