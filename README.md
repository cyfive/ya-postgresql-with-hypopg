# PoC for PostgreSQL 12 in docker 
## Intro
For base image used centos:8 image. For PostgreSQL and hypopg used official PGDG repository. HypoPG official documentation [here](https://hypopg.readthedocs.io/en/latest/)

## Building
```
docker build . -t ya-postgresql-with-hypopg:12
```

## Runing
Interactive:
```
docker run -ti -v `pwd`/pgdata:/var/lib/pgsql/12/data/ -p 5432:5432/tcp ya-postgresql-with-hypopg:12

```
Background:
```
docker run -d -v `pwd`/pgdata:/var/lib/pgsql/12/data/ -p 5432:5432/tcp ya-postgresql-with-hypopg:12
```