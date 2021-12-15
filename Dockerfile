ARG OPENJDK_IMAGE_TAG=8u312-jdk-slim-bullseye
FROM openjdk:${OPENJDK_IMAGE_TAG}

LABEL maintainer="info@redmic.es"

ARG	WGET_VERSION=1.21-1+b1

ENV DIRPATH=/opt/redmic \
	DEFAULT_JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -XshowSettings:vm -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -Dlog4j.formatMsgNoLookups=true -Duser.country=ES -Duser.language=es" \
	LOG_LEVEL=error

RUN apt-get update && apt-get install -y --no-install-recommends \
		wget="${WGET_VERSION}" && \
	rm -rf /var/lib/apt/lists/*

WORKDIR ${DIRPATH}

ENTRYPOINT java ${DEFAULT_JAVA_OPTS} ${JAVA_OPTS} -jar "${DIRPATH}/${MICROSERVICE_NAME}.jar"
