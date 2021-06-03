FROM alpine:3.13

RUN apk add --no-cache --update openssh-client
CMD ssh \ 
    -o StrictHostKeyChecking=no \
    -N ${TUNNEL_HOST} \
    -L ${FORWARD_DSN}

