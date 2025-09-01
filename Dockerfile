FROM nginx:alpine

COPY pod-name.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]

