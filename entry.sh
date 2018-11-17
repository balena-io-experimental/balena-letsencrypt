#!/bin/bash -e

if [ -z "${LETSENCRYPT_DOMAIN}" ]; then
	# shellcheck disable=SC2016
	echo 'ERROR: `LETSENCRYPT_DOMAIN` is not set.'
	sleep 60
	exit 1
fi

if [ -z "${LETSENCRYPT_EMAIL}" ]; then
	# shellcheck disable=SC2016
	echo 'ERROR: `LETSENCRYPT_EMAIL` is not set.'
	sleep 60
	exit 1
fi

# request initial certificate if it does not already exist
HOSTNAME_ARGS=()
IFS=',' read -r -a hostnames <<< "${LETSENCRYPT_HOSTNAMES:-"${BALENA_DEVICE_NAME_AT_INIT},${BALENA_DEVICE_UUID}"}"
for host in "${hostnames[@]}"; do
	HOSTNAME_ARGS+=("-d" "${host}.${LETSENCRYPT_DOMAIN}")
done
if [ ! -d "/etc/letsencrypt/live/${hostnames[1]}.${LETSENCRYPT_DOMAIN}" ]; then
	test -n "${LETSENCRYPT_SERVER}" && SERVER_ARGS=("--server" "${LETSENCRYPT_SERVER}")
	/usr/bin/certbot --config-dir /data -n --agree-tos --email "${LETSENCRYPT_EMAIL}" "${SERVER_ARGS[@]}" certonly --standalone "${HOSTNAME_ARGS[@]}"
fi

# start services
systemctl start haproxy.service
systemctl start certbot-renew.timer

# run the app
exec ./app.sh
