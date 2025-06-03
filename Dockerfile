# === 1. Build Stage ===
FROM node:18-alpine AS builder
WORKDIR /app

# Only copy files necessary for installing dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the project and build it
COPY . .
RUN npm run build

# === 2. Production Stage ===
FROM node:18-alpine AS runner
WORKDIR /app

# Copy only what's needed to run the app
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package*.json ./
RUN npm install --production

EXPOSE 3000
CMD ["npm", "start"]
