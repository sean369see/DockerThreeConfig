# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/go/dockerfile-reference/

# Want to help us make this template better? Share your feedback here: https://forms.gle/ybq9Krt8jtBL3iCk7

ARG NODE_VERSION=26

FROM node:${NODE_VERSION}-alpine

# ENV NPM_CONFIG_PREFIX=/usr/src/.npm-global
# ENV PATH=$PATH:/usr/src/.npm-global/bin


# Use dev node environment by default.
ENV NODE_ENV dev

# trying to fix xdg error
# RUN install xdg-utils

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY package*.json ./
# build fresh in container
# COPY package-lock.json ./

# RUN npm install --production=false
RUN npm install

# this is critical for vite and the project to work 
COPY vite.config.js ./

# This is not necessary to copy to root dir if using COPY . . below
COPY public ./public
COPY src ./src

# Download dependencies as a separate step to take advantage of Docker's caching.
# Leverage a cache mount to /root/.npm to speed up subsequent builds.
# Leverage a bind mounts to package.json and package-lock.json to avoid having to copy them into
# into this layer.
# RUN --mount=type=bind,source=package.json,target=package.json \
#     --mount=type=bind,source=package-lock.json,target=package-lock.json \
#     --mount=type=cache,target=/root/.npm \
#     npm ci --omit=dev

# qqq 
# RUN apk add --no-cache libgl1 libglib2.0-0

# fix permisson denied error
RUN chown -R node:node /usr/src/app 

# Run the application as a non-root user. Disable for BUILD MODE
USER node

# Copy the rest of the source files into the image. Disable see COPY public ./public above
# COPY . .

# Run the application.
# DEV MODE
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]

# BUILD MODE the application via docker 
# CMD ["npm", "run", "build"]

# Expose the port that the application listens on.
EXPOSE 5173
