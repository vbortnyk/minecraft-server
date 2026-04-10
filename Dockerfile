FROM eclipse-temurin:25-jre-alpine

WORKDIR /app

COPY . .

ENV MC_SERVER_NAME=mc-server

ENV APP_PORT=25565

ENV MAX_PLAYERS=5

ENV DIFFICULTY=hard

EXPOSE ${APP_PORT}

RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

