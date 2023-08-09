##
# base image (abstract)
##
FROM python:3.11-slim-buster

LABEL maintainer="Alwyn DSouza"

# Env vars
ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8

# Add trusted hosts for pip install
RUN pip config set global.trusted-host \
    "pypi.org files.pythonhosted.org pypi.python.org" 

# Install OS dependencies
RUN apt-get update && apt-get install -qq -y \
    git gcc build-essential libpq-dev --fix-missing --no-install-recommends \ 
    && apt-get clean

# Set SSL verify off for git
#RUN git config --global http.sslVerify false

# Make sure we are using latest pip
RUN pip install --upgrade pip

# Create directory for dbt config
RUN mkdir -p /root/.dbt
COPY profiles.yml /root/.dbt/profiles.yml

# Copy requirements.txt
COPY requirements.txt requirements.txt

# Install dependencies
RUN pip install -r requirements.txt

EXPOSE 8080
CMD ["/bin/bash"]
