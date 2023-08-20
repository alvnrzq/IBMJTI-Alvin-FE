# Use an official Node.js runtime as the base image
FROM node:14 as build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the Angular app
RUN ng build --configuration=production

# Use a smaller nginx image to serve the application
FROM nginx:alpine

# Copy the built Angular app from the previous stage
COPY ./dist/angular-to-do-list ./usr/share/nginx/html

# Expose port 80 to outside the container
EXPOSE 80
