# Use an official Node.js runtime as a base image
FROM node:14-alpine

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Build the React app (you might need to adjust the build command if using a different setup)
RUN npm run build

# Expose the port that the app will run on
EXPOSE 3000

# Define the command to run your app (adjust the command if needed)
CMD ["npm", "start"]