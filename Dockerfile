FROM python:3.7.5@sha256:dd5a469f9fd76c246c79dc2c863d2e99cf48ce6111ef92b7c63702bcc2a4e1cd
ENV PYTHONUNBUFFERED 1
RUN mkdir /package
WORKDIR /package
COPY bin /scripts
RUN cd /usr/local/bin && for f in /scripts/*; do ln -s "$f" $(basename "${f%.*}"); done
RUN pip install --upgrade --no-cache-dir \
    pip-tools==4.2.0 \
    flake8==3.7.8 \
    isort==4.3.21 \
    pytest==5.1.1
COPY ./code_style_config /root
ARG PIP_EXTRA_INDEX_URL
ENV PIP_EXTRA_INDEX_URL $PIP_EXTRA_INDEX_URL
