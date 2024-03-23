FROM python:3.8-alpine as compile
RUN apk add --no-cache git gcc musl-dev python3-dev libffi-dev openssl-dev cargo
RUN apk add nano vim
RUN python3 -m pip install virtualenv
RUN virtualenv -p python venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --upgrade pip
WORKDIR /opt/
RUN git clone --depth 1 https://github.com/fortra/impacket.git
WORKDIR /opt/impacket
RUN python3 -m pip install .
WORKDIR /opt/impacket/examples
ENTRYPOINT ["/bin/sh"]


