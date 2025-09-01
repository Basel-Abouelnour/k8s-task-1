#!/bin/sh
echo "<h1> Custom nginx image, Hello From pod:  ${POD_NAME:-$HOSTNAME} </h1>" > /usr/share/nginx/html/index.html
exec nginx -g "daemon off;"

