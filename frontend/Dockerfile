# Stage 1: Build the React app
FROM node:22.19.0-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json first (for caching)
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app source
COPY . .

# Build production-ready static files
RUN npm run build


# Stage 2: Nginx to serve the build
FROM nginx:1.28-alpine

# Copy built static files from builder
COPY --from=builder /app/build /usr/share/nginx/html

# (Optional) Copy custom nginx config
# COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

# Use standard nginx startup command
CMD ["nginx", "-g", "daemon off;"]
