FROM alpine:3.22.1
RUN <<EOF
apk update &&
apk add ruby-full ruby-dev build-base
EOF
COPY src /app
WORKDIR /app
RUN <<EOF
bundle install &&
mkdir /home/secret &&
echo -e "# Congratulations\n# SSU{3xt3ns1bl3_LFI_L4ngu4ge-UAKMnbLKXXX9}" > /home/secret/.bashrc &&
adduser -H -D -s /bin/nologin -s "check my .bashrc" secret -h /home/secret &&
adduser -H -D -s /bin/nologin ruby &&
chown -R ruby:ruby /app &&
chmod +x /app/docker-entrypoint.sh
EOF
USER ruby:ruby
CMD ["/bin/ash", "/app/docker-entrypoint.sh"]
