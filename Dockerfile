# Gunakan versi node yang lebih baru dan stabil
FROM node:18-alpine AS build
WORKDIR /app

# Copy dulu file pendukung buat ngetes dependencies
COPY package.json package-lock.json* ./

# Coba install dependencies (Kalau gak ada package-lock, dia bakal buat otomatis)
RUN npm install

# Copy seluruh source code
COPY . .

# Build aplikasinya
RUN npm run build

# Stage 2: Nginx
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]