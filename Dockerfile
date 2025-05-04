# Etapa 1: Build limpio con entorno compatible
FROM node:18-bullseye AS build
WORKDIR /app

# Instalar solo dependencias primero (para aprovechar cache)
COPY package.json package-lock.json ./
RUN npm cache clean --force \
    && rm -rf node_modules \
    && npm install

# Copiar el resto del proyecto
COPY . .

# Ejecutar build
RUN npm run build

# Etapa 2: Contenedor final con Nginx
FROM nginx:stable-alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
