# balena-letsencrypt

**NOTE: THIS APPLICATION IS NOT YET SUPPORTED BY BALENA CLOUD**

This is an example application which you can build upon to use Lets Encrypt in your Balena application; just replace `app.sh`!

### Configuration

* `LETSENCRYPT_DOMAIN` and `LETSENCRYPT_EMAIL` must be set
* `LETSENCRYPT_HOSTNAMES` can be used to dictate the subdomains (default: `BALENA_DEVICE_NAME_AT_INIT` and `BALENA_DEVICE_UUID`)
* `LETSENCRYPT_SERVER` can be used to override the Lets Encrypt endpoint
