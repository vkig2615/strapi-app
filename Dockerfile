# Use official Node.js image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the project files
COPY . .

# Build the Strapi application
RUN npm run build

# Expose port 1337
EXPOSE 1337

# Start the Strapi application
CMD ["npm", "run", "start"]

