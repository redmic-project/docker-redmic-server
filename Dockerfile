ARG IMAGE_TAG=8u312-jdk-slim-bullseye
FROM openjdk:${IMAGE_TAG}

LABEL maintainer="info@redmic.es"

ARG	LOCALES_VERSION=2.31-13+deb11u2 \
	WGET_VERSION=1.21-1+b1 \
	LANG=es_ES.UTF-8

ENV LANG=${LANG} \
	DIRPATH=/opt/redmic \
	DEFAULT_JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -XshowSettings:vm -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -Dlog4j.formatMsgNoLookups=true" \
	LOG_LEVEL=error

RUN apt-get update && apt-get install -y --no-install-recommends \
		locales="${LOCALES_VERSION}" \
		wget="${WGET_VERSION}" && \
	rm -rf /var/lib/apt/lists/* && \
	sed -i -e "s/# ${LANG} UTF-8/${LANG} UTF-8/" /etc/locale.gen && \
	dpkg-reconfigure --frontend=noninteractive locales && \
	update-locale LANG="${LANG}"

WORKDIR ${DIRPATH}

ENTRYPOINT java ${DEFAULT_JAVA_OPTS} ${JAVA_OPTS} -jar "${DIRPATH}/${MICROSERVICE_NAME}.jar"
