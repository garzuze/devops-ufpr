FROM node:24 AS build

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# etapa só pra instalar deps de produção limpas
FROM node:24 AS deps

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci --omit=dev

# imagem final
FROM node:24-alpine

WORKDIR /usr/src/app
COPY --from=build /usr/src/app/dist ./dist
COPY --from=deps /usr/src/app/node_modules ./node_modules

EXPOSE 3000
CMD ["node", "dist/main"]
