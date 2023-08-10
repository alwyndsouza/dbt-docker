##
# base image (abstract)
##
FROM python:3.11-slim-bullseye

LABEL maintainer="Alwyn DSouza"

# Env vars
ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8
ENV DBT_PROFILES_DIR=/usr/src/dbt

WORKDIR /usr/src/dbt

# Add trusted hosts for pip install
RUN pip config set global.trusted-host \
    "pypi.org files.pythonhosted.org pypi.python.org databricks.com"

# Install OS dependencies
RUN apt-get update && apt-get install -qq -y \
    git gcc build-essential libpq-dev ca-certificates --fix-missing --no-install-recommends \ 
    && update-ca-certificates \
    && apt-get clean

# Make sure we are using latest pip
RUN pip install --upgrade pip

# Copy requirements.txt
COPY requirements.txt requirements.txt

# Install dependencies
RUN pip install -r requirements.txt

#EXPOSE 8080
#CMD ["/bin/bash"]
CMD dbt deps  && sleep infinity
