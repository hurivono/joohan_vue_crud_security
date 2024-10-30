# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
COPY nginx.conf ./
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY --from=build-stage /app/nginx.conf /etc/nginx/conf.d/default.conf

### Azure Opentelemetry ###
COPY agent/applicationinsights-agent-3.5.4.jar applicationinsights-agent-3.5.4.jar
COPY agent/applicationinsights.json applicationinsights.json
ENV APPLICATIONINSIGHTS_CONNECTION_STRING="InstrumentationKey=02a052e7-48b4-408a-ad85-9dfcefed3b77;IngestionEndpoint=https://koreacentral-0.in.applicationinsights.azure.com/;LiveEndpoint=https://koreacentral.livediagnostics.monitor.azure.com/;ApplicationId=56ac42e7-29ef-47d4-b061-d0715aa7deda"
### Azure Opentelemetry ###

### Azure Opentelemetry ###
# ENV JAVA_OPTS="${JAVA_OPTS} -javaagent:applicationinsights-agent-3.5.4.jar"
### Azure Opentelemetry ###

ENV BACKEND_API_URL backend
RUN sed -i "s|backend_host|$BACKEND_API_URL|g" -i /etc/nginx/conf.d/default.conf

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
