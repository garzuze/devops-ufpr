# Vamos preparar o cenário para executar o que queremos
FROM node:24

# Pode ser qualquer nome no node. O workdir serve para não ficarmos dando cd toda hora
WORKDIR /teste/aula

# COPY <LOCAL> <REMOTO>
# Ele executa os comandos de forma síncrona, um após o outro; espera terminar a operação anterior
COPY package*.json .

# Eu sei que o npm ja esta instalado pois eh uma imagem de node
RUN npm install

COPY . .

# Salienta que essa imagem pretende usar uma porta de rede 

EXPOSE 3000

CMD ["npm", "start", "dev"]
