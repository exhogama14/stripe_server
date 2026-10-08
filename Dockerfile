FROM node:18

RUN apt-get update && apt-get install -y wget && \
    wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb -O /tmp/cloudflared.deb && \
    dpkg -i /tmp/cloudflared.deb && \
    rm /tmp/cloudflared.deb && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package.json .
RUN npm install

COPY server.js .
COPY template.html .

EXPOSE 5000

CMD ["node", "server.js"]
