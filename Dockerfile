#base image node:alpine y llamalo builder
FROM node:20-alpine as builder
#crea un directorio de trabajo: /app
WORKDIR '/app'
#copia el package.json para el install de node_modules
COPY package.json .
#instala las dependencias a utilizar segun el.json
RUN npm install
#copia el resto del codigo fuente
COPY . .
#hace el build de toda la app
RUN npm run build

#comenzamos otra imagen con la base nginx
FROM nginx
#copiamos el codigo copilado al directorio donde nginx lo expone a la web (puerto 80)
COPY --from=builder /app/build /usr/share/nginx/html
