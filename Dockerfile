FROM node:18-alpine  # أو أي إصدار Node متوافق مع مشروعك
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
CMD ["npm", "start"]
