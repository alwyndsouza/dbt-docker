##
# base image (abstract)
##
FROM python:3.8.1-slim-buster

LABEL maintainer="Alwyn DSouza"

# Env vars
ENV DBT_HOME=/usr/app
ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8

# Set working directory
# WORKDIR /app

# Add trusted hosts for pip install
RUN pip config set global.trusted-host \
    "pypi.org files.pythonhosted.org pypi.python.org" 

# Install OS dependencies
RUN apt-get update && apt-get install -qq -y \
    git gcc build-essential libpq-dev --fix-missing --no-install-recommends \ 
    && apt-get clean

# Set SSL verify off for git
RUN git config --global http.sslVerify false

# Make sure we are using latest pip
# Update python
RUN pip install --upgrade pip setuptools wheel --no-cache-dir

# Make sure we are using latest pip
RUN pip install --upgrade pip

# Create directory for dbt config
RUN mkdir -p /root/.dbt
RUN mkdir -p ${DBT_HOME}

# Copy requirements.txt
COPY requirements.txt requirements.txt

# Install dependencies
RUN pip install -r requirements.txt

# Copy dbt profile
COPY profiles.yml /root/.dbt/profiles.yml

# Set docker basics
#WORKDIR /usr/app/dbt/
#ENTRYPOINT ["dbt"]

# Start the dbt RPC server
CMD ["dbt-rpc", "serve"]
