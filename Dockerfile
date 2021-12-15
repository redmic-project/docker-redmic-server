ARG IMAGE_TAG=8u312-jdk-slim-bullseye
FROM openjdk:${IMAGE_TAG}

LABEL maintainer="info@redmic.es"

ENV DIRPATH=/opt/redmic \
	SPRING_PROFILES_ACTIVE=dev \
	DEFAULT_JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -XshowSettings:vm -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -Dlog4j.formatMsgNoLookups=true" \
	LOG_LEVEL=error

WORKDIR ${DIRPATH}

ENTRYPOINT java ${DEFAULT_JAVA_OPTS} ${JAVA_OPTS} -jar ${DIRPATH}/${MICROSERVICE_NAME}.jar
