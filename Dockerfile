FROM node:24 AS build

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build
RUN npm prune --omit=dev && npm cache clean --force

FROM node:24-alpine

WORKDIR /usr/src/app

COPY --from=build usr/src/app/dist ./dist
COPY --from=build usr/src/app/node_modules ./node_modules
#daqui pra baixo é execução do projeto

EXPOSE 3000

CMD ["npm", "run", "start"]