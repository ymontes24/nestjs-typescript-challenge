FROM node:18-alpine as base

WORKDIR /app

COPY package.json ./

RUN npm install -g @nestjs/cli

RUN npm install

COPY . .

CMD npm run start

EXPOSE 3000