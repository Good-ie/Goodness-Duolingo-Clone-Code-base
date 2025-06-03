# 1. Base image
FROM node:18

# 2. Set working directory
WORKDIR /app

# 3. Copy dependencies and install
COPY package*.json ./
RUN npm install

# 4. Copy the rest of the app
COPY . .

# 5. Build the app (add this!)
RUN npm run build

# 6. Expose port and start
EXPOSE 3000
CMD ["npm", "start"]