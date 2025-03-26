# Build stage
FROM node:20-alpine as builder
WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Build TypeScript code
RUN npm run build

# Production stage
FROM node:20-alpine
WORKDIR /app

# Copy package files and install production dependencies
COPY package*.json ./
RUN npm install --production

# Copy built files from builder stage
COPY --from=builder /app/dist ./dist

# Set environment variables
ENV NODE_ENV=production
ENV PORT=54243
ENV HOST=0.0.0.0

# Expose port
EXPOSE 54243

# Start the server
CMD ["npm", "start"]