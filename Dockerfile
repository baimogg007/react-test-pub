# Fetching the latest node image on apline linux
FROM node:18.12.1 AS builder

# Declaring env
ENV NODE_ENV production

# Setting up the work directory
WORKDIR /usr/src/app

# Installing dependencies
COPY ./package.json ./yarn.lock ./

RUN yarn install

# Copying all the files in our project
COPY . ./

# Building our application
RUN yarn build

# Fetching the latest nginx image
FROM nginx

# Copying built assets from builder
COPY --from=builder /usr/src/app/build /usr/share/nginx/html/

# Copying our nginx.conf
COPY --from=builder /usr/src/app/nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8090
