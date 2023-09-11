FROM alpine:2.25-r0
ENV NGINX_VERSION nginx-1.20.2
RUN apk update && apk add nginx=1.20.2-r0
EXPOSE 80
EXPOSE 8080
COPY index.html /usr/share/nginx/html/
COPY default.conf /etc/nginx/http.d/
CMD ["nginx", "-g", "daemon off;"] 