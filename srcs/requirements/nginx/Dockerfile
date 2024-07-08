FROM alpine:3.19

RUN apk update && apk upgrade && apk add --no-cache nginx


COPY requirements/nginx/tools/gbreana.42.fr.crt /etc/nginx/ssl/
COPY requirements/nginx/tools/gbreana.42.fr.key /etc/nginx/ssl/
COPY requirements/nginx/config/gbreana.42.fr.conf /etc/nginx/sites-available/
COPY requirements/nginx/config/chat.gbreana.42.fr.conf /etc/nginx/sites-available/
COPY requirements/nginx/config/db.gbreana.42.fr.conf /etc/nginx/sites-available/

RUN rm -rf /etc/nginx/http.d/default.conf && \
    ln -s /etc/nginx/sites-available/gbreana.42.fr.conf /etc/nginx/http.d/ && \
    ln -s /etc/nginx/sites-available/db.gbreana.42.fr.conf /etc/nginx/http.d/ && \
    ln -s /etc/nginx/sites-available/chat.gbreana.42.fr.conf /etc/nginx/http.d/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]