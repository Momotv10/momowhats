# استخدام إصدار Node.js الكامل
FROM node:16-bullseye-slim

# تحديد مجلد العمل
WORKDIR /app

# تثبيت التحديثات وأدوات النظام الأساسية أولاً
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

# تعيين المتغيرات البيئية
ENV PUPPETEER_SKIP_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# نسخ ملفات الحزمة أولاً للاستفادة من طبقات Docker
COPY package.json package-lock.json ./

# تثبيت التبعيات - تأكد من أن npm موجود
RUN npm install --legacy-peer-deps

# نسخ باقي الملفات
COPY . .

# فتح البورت الافتراضي
EXPOSE 3000

# تشغيل التطبيق
CMD ["npm", "start"]
