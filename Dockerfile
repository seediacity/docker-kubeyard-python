FROM python:3.7.6@sha256:82c0433e53cc107a6481c45ef9304a27603ac740c2e438fb48fecd7cf6af4ca6
ENV PYTHONUNBUFFERED 1
RUN mkdir /package
WORKDIR /package
COPY bin /scripts
RUN cd /usr/local/bin && for f in /scripts/*; do ln -s "$f" $(basename "${f%.*}"); done
RUN pip install --upgrade --no-cache-dir \
    pip-tools==4.2.0 \
    flake8==3.7.8 \
    isort==4.3.21 \
    pytest==5.3.2
COPY ./code_style_config /root
ARG PIP_EXTRA_INDEX_URL
ENV PIP_EXTRA_INDEX_URL $PIP_EXTRA_INDEX_URL
