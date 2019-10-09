FROM node as node
WORKDIR /app

COPY package*.json ./
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
RUN cnpm install
COPY ./ /app
RUN npm run build

FROM nginx
RUN mkdir /app
VOLUME ./logs:/var/log/nginx
COPY --from=node /app/dist /app
COPY nginx.conf /etc/nginx/nginx.conf
