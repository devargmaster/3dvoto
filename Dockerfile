FROM node:18-bullseye AS build
WORKDIR /app

# Copiar solo package.json y lock primero para optimizar cache
COPY package.json package-lock.json ./

# Eliminar locks potencialmente corruptos dentro del contenedor
RUN npm cache clean --force \
    && rm -rf node_modules \
    && npm install

# Ahora sí copiamos el resto del proyecto
COPY . .

RUN npm run build

FROM nginx:stable-alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
