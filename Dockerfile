FROM alpine:3 as intermediate

LABEL stage=intermediate

RUN apk update
RUN apk add --update git
RUN git clone https://github.com/carbon-app/carbon.git

FROM node:18

COPY --from=intermediate /carbon /carbon

WORKDIR /carbon

RUN yarn install
RUN npm run-script build

ENTRYPOINT ["npm", "run-script", "start"]