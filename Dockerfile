# Stage 0, based on Node.js, to build and compile Angular
FROM node:10-alpine as node
 
WORKDIR /app
 
COPY package*.json /app/
 
RUN npm install
 
COPY ./ /app/
 
ARG TARGET=ng-deploy
 
RUN npm run ${TARGET}
 
# STAGE 1, based on Nginx, to have only the compiled app, ready for production with Nginx
FROM nginx:1.13
 
COPY --from=node /app/dist/ /usr/share/nginx/html
 
COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf
EXPOSE 80