# balena-letsencrypt

This is an example application which you can build upon to use Lets Encrypt in your Balena application; just replace `app.sh`!

### Configuration

* `LETSENCRYPT_DOMAIN` and `LETSENCRYPT_EMAIL` must be set
* `LETSENCRYPT_HOSTNAMES` can be used to dictate the subdomains (default: `BALENA_DEVICE_NAME_AT_INIT` and `BALENA_DEVICE_UUID`)
* `LETSENCRYPT_SERVER` can be used to override the Lets Encrypt endpoint

### API Configuration

Application Domain Mapping (application devices are available at `uuid.DOMAIN` and `name.DOMAIN`):

```sh
API_KEY="..."
APP_ID=1
DOMAIN="example.com"

curl -vskL \
    -X POST \
    -H "Authorization: Bearer ${API_KEY}" \
    -H "Content-Type: application/json" \
    -d "{\"application\": ${APP_ID}, \"domain\": \"${DOMAIN}\"}" \
    "https://api.balena-cloud.com/v5/application_domain_mapping"
```

Device Domain Mapping (specific device is accessible via `FQDN`):

```sh
API_KEY="..."
DEVICE_ID=1
FQDN="device${DEVICE_ID}.example.com"

curl -vskL \
    -X POST \
    -H "Authorization: Bearer ${API_KEY}" \
    -H "Content-Type: application/json" \
    -d "{\"device\": ${DEVICE_ID}, \"fqdn\": \"${FQDN}\"}" \
    "https://api.balena-cloud.com/v5/device_domain_mapping"
```
