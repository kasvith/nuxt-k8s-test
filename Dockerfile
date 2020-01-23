FROM node:lts AS builder
WORKDIR /src
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run generate

FROM nginx:latest
COPY --from=builder /src/dist /usr/share/nginx/html
EXPOSE 80
