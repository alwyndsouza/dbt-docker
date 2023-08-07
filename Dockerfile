##
# base image (abstract)
##
FROM python:3.9-slim

#RUN python config --set ssl_verify false 

# System setup
RUN apt-get update \
  && apt-get dist-upgrade -y \
  && apt-get install -y --no-install-recommends \
    git \
    ssh-client \
    software-properties-common \
    make \
    build-essential \
    ca-certificates \
    libpq-dev \
  && apt-get clean \
  && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

# Env vars
ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8


# Update python
RUN pip config set global.http.sslVerify false
RUN pip install --upgrade pip setuptools wheel --no-cache-dir --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org

# Set docker basics
WORKDIR /usr/app/dbt/
ENTRYPOINT ["dbt"]


RUN pip install dbt-databricks --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org


