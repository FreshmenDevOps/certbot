#!/bin/bash
if [ -z "$1" ]; then
  echo "Usage: $0 domain.name"
  exit 1
fi
DOMAIN="$1"
: ${DOMAINS:="www. admin. mail."}
read -a DOMAINS <<< $DOMAINS
: ${MAIL:="devops@freshmen.eu"}

DS=( "-d" "$DOMAIN" )
for d in "${DOMAINS[@]}"; do
	DS+=( "-d" "${d}${DOMAIN}" )
done
docker run --rm \
		-v $HOME/etc/:/etc/letsencrypt/ \
		-v /srv/www:/srv/www certbot certonly \
		--webroot -w "/srv/www/$DOMAIN/" \
		--email "$MAIL" --agree-tos --non-interactive \
		${DS[@]}

