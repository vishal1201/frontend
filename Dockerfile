# BUILD Phase
FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

# Generate build of npm src into static files. Use this in RUN phase
RUN npm run build

# RUN Phase
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html