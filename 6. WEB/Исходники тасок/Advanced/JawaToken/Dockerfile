FROM alpine:3.22.1
RUN <<EOF
apk update &&
apk add python3 &&
apk add py3-pip
EOF
COPY src /app
WORKDIR /app
RUN <<EOF
rm /usr/lib/python*/EXTERNALLY-MANAGED &&
pip3 install -r requirements.txt &&
adduser -H -D -s /bin/nologin python &&
chown -R python:python /app &&
chmod +x /app/docker-entrypoint.sh
EOF
USER python:python
CMD ["/bin/ash", "/app/docker-entrypoint.sh"]
