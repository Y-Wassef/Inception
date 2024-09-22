FROM debian:bullseye

RUN apt-get -y update && apt-get install -y \
    vim \
    curl \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/ssl/jwadie-a.crt \
    -keyout /etc/nginx/ssl/jwadie-a.key \
    -subj "/C=FR/ST=Angouleme/L=42Angouleme/O=Ecole42/OU=42Angouleme/CN=jwadie-a.42.fr/"

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
