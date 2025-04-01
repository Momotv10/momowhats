# استخدام إصدار Node.js المناسب مع Puppeteer
FROM node:18-bullseye-slim

# تحديد مجلد العمل
WORKDIR /app

# تثبيت الأدوات اللازمة لـ Chromium
RUN apt-get update && apt-get install -y \
    chromium \
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libnspr4 \
    libnss3 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

# تحديد مسار Chromium لمنع Puppeteer من تنزيل إصدار جديد
ENV PUPPETEER_SKIP_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# نسخ ملفات التهيئة وتثبيت الحزم
COPY package.json package-lock.json ./
RUN npm install --legacy-peer-deps

# نسخ باقي الملفات إلى الحاوية
COPY . .

# تشغيل التطبيق
CMD ["npm", "start"]
