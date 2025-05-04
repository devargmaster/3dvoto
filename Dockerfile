# Dockerfile para producción con build hecho localmente
FROM nginx:stable-alpine
WORKDIR /usr/share/nginx/html

COPY dist/ .

# Configuración de Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf
