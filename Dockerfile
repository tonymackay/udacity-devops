FROM node:latest

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY app/package.json /usr/src/app
RUN npm install

# Copy app files
COPY app/app.js /usr/src/app

# If you are building your code for production
RUN npm ci --only=production

EXPOSE 8080
CMD [ "node", "app.js" ]
