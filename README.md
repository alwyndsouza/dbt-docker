

![dbt-logo](dbt-docker.png)

  

# Docker for dbt databricks

```
 ___________
<  DBT  DATABRICKS  >
 -----------
    \
     \
      \
                    ##        .
              ## ## ##       ==
           ## ## ## ##      ===
       /""""""""""""""""___/ ===
  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
       \______ o          __/
        \    \        __/
          \____\______/
```

  

## Overview

This repository contains the code to build docker image for dbt-databricks

  

## Building an image:

  

1. Specify the version dbt-databricks version in requirements.txt

2. Update the environment variables in .env

  

```

BUILD_VERSION={{ Ideally should be same as dbt version }}

DBT_PROJECT={{ dbt project path }}

DBT_PROFILES={{ path to profiles.yml }}
```

3. Build the image and start the container by running the command : ``sh start_docker_stack.sh``

  

4. Stop the container by running the command: ``sh stop_docker_stack.sh``

  

## Testing the setup

  

### Test the setup

  

`docker exec -it dbt dbt --version`

  

```

sh-3.2$ docker exec -it dbt dbt --version

Core:

- installed: 1.6.0

  

The latest version of dbt-core could not be determined!

Make sure that the following URL is accessible:

https://pypi.org/pypi/dbt-core/json

  

Plugins:

- databricks: 1.6.0 - Could not determine latest version

- spark: 1.6.0 - Could not determine latest version

```

  

### Test the connection.

`docker exec -it dbt dbt debug`


```

sh-3.2$ docker exec -it dbt dbt debug

12:37:38 Running with dbt=1.6.0

12:37:38 dbt version: 1.6.0

12:37:38 python version: 3.11.4

12:37:38 python path: /usr/local/bin/python

12:37:38 os info: Linux-5.15.49-linuxkit-pr-aarch64-with-glibc2.31

12:37:39 Using profiles dir at /usr/src/dbt

12:37:39 Using profiles.yml file at /usr/src/dbt/profiles.yml

12:37:39 Using dbt_project.yml file at /usr/src/dbt/dbt_project.yml

12:37:39 adapter type: databricks

12:37:39 adapter version: 1.6.0

12:37:39 Configuration:

12:37:39 profiles.yml file [OK found and valid]

12:37:39 dbt_project.yml file [OK found and valid]

12:37:39 Required dependencies:

12:37:39 - git [OK found]

  

12:37:39 Connection:

12:37:39 host: xyzxz

12:37:39 http_path: xyzxz

12:37:39 catalog: xyzxz

12:37:39 schema: xyzxz

12:37:39 Registered adapter: databricks=1.6.0

12:37:39 databricks-sql-connector adapter: Successfully opened session abc-abc-abc

12:37:40 databricks-sql-connector adapter: Closing sessionabc-abc-abc

12:37:40 Connection test: [OK connection ok]

  

12:37:40 All checks passed!
```

### Adding alias to bash profile

On Mac , you can add the below line to .zshrc file

`alias dbt-databricks="docker exec -it dbt dbt "`

once added execute,
source ~./zshrc

You can then run the shorthand command as follows

```

% dbt-databricks --version

Core:

- installed: 1.6.0

  

The latest version of dbt-core could not be determined!

Make sure that the following URL is accessible:

https://pypi.org/pypi/dbt-core/json

  

Plugins:

- databricks: 1.6.0 - Could not determine latest version

- spark: 1.6.0 - Could not determine latest version

  

% dbt-databricks debug

05:28:24 Running with dbt=1.6.0

05:28:24 dbt version: 1.6.0

05:28:24 python version: 3.11.4

05:28:24 python path: /usr/local/bin/python

05:28:24 os info: Linux-5.15.49-linuxkit-pr-aarch64-with-glibc2.31

05:28:25 Using profiles dir at /usr/src/dbt

05:28:25 Using profiles.yml file at /usr/src/dbt/profiles.yml

05:28:25 Using dbt_project.yml file at /usr/src/dbt/dbt_project.yml

05:28:25 adapter type: databricks

05:28:25 adapter version: 1.6.0

05:28:25 Configuration:

05:28:25 profiles.yml file [OK found and valid]

05:28:25 dbt_project.yml file [OK found and valid]

05:28:25 Required dependencies:

05:28:25 - git [OK found]

  

05:28:25 Connection:

05:28:25 host: group-ds-dev.cloud.databricks.com

05:28:25 http_path: /sql/1.0/warehouses/xxxx

05:28:25 catalog: abc

05:28:25 schema: abc_abc

05:28:25 Registered adapter: databricks=1.6.0

05:28:25 Connection test: [OK connection ok]

  

05:28:25 All checks passed!
```

