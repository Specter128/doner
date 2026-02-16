# Mercaro – deploy Railway (același conținut ca Dockerfile din rădăcină)
# În Railway: Variables → RAILWAY_DOCKERFILE_PATH = railway/Dockerfile
# Build context = rădăcina repo (unde sunt backend/ și frontend/)

# Stage 1: Build backend
FROM node:20-alpine AS backend-builder
WORKDIR /app/backend
COPY backend/package*.json ./
RUN npm ci
COPY backend/ ./
RUN npm run build

# Stage 2: Build frontend
FROM node:20-alpine AS frontend-builder
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm ci
COPY frontend/ ./
RUN npm run build

# Stage 3: Runtime
FROM node:20-alpine
WORKDIR /app

COPY --from=backend-builder /app/backend/dist ./backend/dist
COPY --from=backend-builder /app/backend/package*.json ./backend/
COPY --from=backend-builder /app/backend/node_modules ./backend/node_modules
COPY --from=frontend-builder /app/frontend/dist ./frontend/dist

WORKDIR /app/backend
RUN mkdir -p uploads/listings uploads/avatars

ENV NODE_ENV=production
ENV PORT=3000
ENV HOST=0.0.0.0
ENV PUBLIC_DIR=/app/frontend/dist

EXPOSE 3000
CMD ["node", "dist/index.js"]
