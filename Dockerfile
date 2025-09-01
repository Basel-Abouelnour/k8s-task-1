FROM nginx:alpine

RUN echo "<h1> Custom nginx image by Basel $(HOSTNAME)</h1>" > /usr/share/nginx/html/index.html
