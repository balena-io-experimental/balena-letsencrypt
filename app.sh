#!/bin/bash -e

mkdir -p www; cd www
cat >index.html <<EOF
<!DOCTYPE html>
<html>
	<head><title>balena-letsencrypt</title></head>
	<body>Hello, ${BALENA_DEVICE_UUID}!</body>
</html>
EOF
python3 -m http.server
