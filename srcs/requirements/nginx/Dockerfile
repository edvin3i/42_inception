FROM alpine:3.20

RUN apk update && apk upgrade && apk add --no-cache nginx


COPY ./tools/gbreana.42.fr.crt /etc/nginx/ssl/
COPY ./tools/gbreana.42.fr.key /etc/nginx/ssl/
COPY ./config/default.conf /etc/nginx/sites-available/

RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]