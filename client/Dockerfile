# Build stage
FROM node:20-alpine as builder
WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Production stage
FROM nginx:alpine
WORKDIR /usr/share/nginx/html

# Copy built assets from builder stage
COPY --from=builder /app/build .

# Copy nginx configuration (if needed)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port
EXPOSE 58440

# Start nginx
CMD ["nginx", "-g", "daemon off;"]