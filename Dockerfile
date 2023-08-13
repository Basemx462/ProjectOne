# Use the official Node.js base image with the desired version
FROM node:14

# Set the working directory inside the container
WORKDIR /home/nodeapp

# Copy the package.json and package-lock.json files into the container
COPY package*.json ./

# Install dependencies using npm
RUN npm install

# Copy all the files from your local directory into the container
COPY . .

# Expose the port on which your Node.js application listens (replace 3000 with your desired port)
EXPOSE 3000

# Define the command to run your Node.js application (replace "app.js" with your entry point file)
CMD ["node", "app.js"]
