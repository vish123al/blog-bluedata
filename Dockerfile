FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html
COPY /css/ /usr/share/nginx/html/css/
COPY /icon-fonts/ /usr/share/nginx/html/icon-fonts/
COPY /img/ /usr/share/nginx/html/img/
COPY /js/ /usr/share/nginx/html/js/
