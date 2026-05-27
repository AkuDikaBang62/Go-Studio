# Tahap 1: Build aplikasi React/Vite
FROM node:20-alpine AS build
WORKDIR /app

# Salin file package.json untuk install dependencies
COPY package.json ./

# Gunakan npm install untuk mengunduh semua package
RUN npm install --legacy-peer-deps

# Salin seluruh source code proyek
COPY . .

# Proses build aplikasi (menghasilkan folder 'dist')
RUN npm run build

# Tahap 2: Jalankan menggunakan Nginx Web Server
FROM nginx:alpine

# Menyalin hasil build dari tahap 1 ke folder HTML Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Ekspos port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]