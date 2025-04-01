# استخدام إصدار Node.js المناسب مع Puppeteer
FROM node:18-bullseye-slim

# تحديد مجلد العمل
WORKDIR /app

# تثبيت الأدوات اللازمة لـ Chromium و Puppeteer
RUN apt-get update && apt-get install -y \
    chromium-browser \
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
    libgbm-dev \
    libxcb1 \
    libx11-xcb1 \
    libxrender1 \
    libxshmfence1 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# تحديد مسار Chromium لمنع Puppeteer من تنزيل إصدار جديد
ENV PUPPETEER_SKIP_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# نسخ ملفات التهيئة وتثبيت الحزم
COPY package.json package-lock.json ./
RUN npm ci --omit=dev

# نسخ باقي الملفات إلى الحاوية
COPY . .

# إضافة مستخدم غير root للأمان
RUN useradd --no-create-home puppeteer \
    && chown -R puppeteer:puppeteer /app
USER puppeteer

# تشغيل التطبيق
CMD ["npm", "start"]
