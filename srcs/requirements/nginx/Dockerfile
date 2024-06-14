FROM alpine:3.20

RUN apk update && apk upgrade && apk add --no-cache nginx


COPY requirements/nginx/tools/gbreana.42.fr.crt /etc/nginx/ssl/
COPY requirements/nginx/tools/gbreana.42.fr.key /etc/nginx/ssl/
COPY requirements/nginx/config/default.conf /etc/nginx/sites-available/

RUN rm -rf /etc/nginx/http.d/default.conf && \
    ln -s /etc/nginx/sites-available/default.conf /etc/nginx/http.d/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]