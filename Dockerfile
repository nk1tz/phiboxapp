FROM node:alpine as builder
WORKDIR /app
COPY package.json ./
COPY yarn.lock ./
RUN yarn install
COPY . .
RUN yarn build

FROM node:alpine
RUN yarn global add serve
WORKDIR /app
COPY --from=builder /app/build .
EXPOSE 88
CMD ["serve", "-p", "88", "-s", "."]

