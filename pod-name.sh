#!/bin/sh
echo "<h1> Custom nginx image, Hello From pod: $HOSTNAME </h1>" > /usr/share/nginx/html/index.html
exec nginx -g "daemon off;"

