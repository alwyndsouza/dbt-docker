##
# base image (abstract)
##
FROM python:3.11-slim-bullseye

LABEL maintainer="Alwyn DSouza"

# Env vars
ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8

WORKDIR /usr/src/dbt

# Add trusted hosts for pip install
#RUN pip config set global.trusted-host \
#    "pypi.org files.pythonhosted.org pypi.python.org"

# Install OS dependencies
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
    #ca-certificates \
    #git gcc build-essential libpq-dev ca-certificates --fix-missing --no-install-recommends \ 
    && update-ca-certificates -v \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean
    

# Make sure we are using latest pip
RUN pip install --upgrade pip

# Copy requirements.txt
COPY requirements.txt requirements.txt

# Install dependencies
RUN pip install -r requirements.txt \
    && pip cache purge

CMD dbt deps  && sleep infinity
