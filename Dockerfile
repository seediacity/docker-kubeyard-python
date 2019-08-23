FROM python:3.7.4@sha256:4432d65bd7da4693bb9365c3369ed5c7f0cb472195a294c54d1b766751098f7b
ENV PYTHONUNBUFFERED 1
RUN mkdir /package
WORKDIR /package
COPY bin /scripts
RUN cd /usr/local/bin && for f in /scripts/*; do ln -s "$f" $(basename "${f%.*}"); done
RUN pip install --upgrade --no-cache-dir \
    pip-tools==3.4.0 \
    flake8==3.5.0 \
    isort==4.3.4 \
    pytest==3.8.1
COPY ./code_style_config /root
ARG PIP_EXTRA_INDEX_URL
ENV PIP_EXTRA_INDEX_URL $PIP_EXTRA_INDEX_URL
