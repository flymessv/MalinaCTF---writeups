FROM alpine:3.22.1
RUN <<EOF
apk update &&
apk add ruby-full ruby-dev build-base
EOF
COPY src /app
WORKDIR /app
RUN <<EOF
bundle install &&
adduser -H -D -s /bin/nologin ruby &&
chown -R ruby:ruby /app &&
chmod +x /app/docker-entrypoint.sh
EOF
USER ruby:ruby
CMD ["/bin/ash", "/app/docker-entrypoint.sh"]
COPY flag.txt /
