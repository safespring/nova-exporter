FROM alpine:3.11

RUN apk add --update python3 py3-cffi py3-cryptography py3-netifaces
RUN python3 -m venv --system-site-packages /venv
COPY . /src
RUN mkdir -p /etc/openstack
RUN adduser -u 1001 -h /home/admin -s /bin/sh -D admin
RUN mkdir -p /home/admin/.config/openstack
RUN chown -R admin:admin /home/admin
RUN . /venv/bin/activate; \
        cd /src; \
        pip install -e .

USER admin

ENTRYPOINT ["/venv/bin/nova-exporter"]
