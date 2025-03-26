# Stage 1: Build the client
FROM node:20-alpine as client-builder
WORKDIR /app/client
COPY client/package*.json ./
RUN npm install
COPY client/ ./
RUN npm run build

# Stage 2: Build the server
FROM node:20-alpine as server-builder
WORKDIR /app/server
COPY server/package*.json ./
RUN npm install
COPY server/ ./
RUN npm run build

# Stage 3: Production environment
FROM node:20-alpine
WORKDIR /app

# Copy package.json files
COPY package*.json ./
RUN npm install

# Copy built client files
COPY --from=client-builder /app/client/build ./client/build

# Copy server files and dependencies
COPY --from=server-builder /app/server/dist ./server/dist
COPY --from=server-builder /app/server/package*.json ./server/
RUN cd server && npm install --production

# Set environment variables
ENV NODE_ENV=production
ENV PORT=54243
ENV HOST=0.0.0.0

# Expose ports for both client and server
EXPOSE 54243
EXPOSE 58440

# Copy the start script
COPY start.sh ./
RUN chmod +x start.sh

# Start the application
CMD ["./start.sh"]