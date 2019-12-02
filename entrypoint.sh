#!/bin/bash

# 
# Entry point script for PostgreSQL
# Author: Stanislav V. Emets <emetssv@mail.ru>
#

PGDATA=${PGDATA:-/var/lib/pgsql/12/data/}

if [ $# -eq 0 ]; then

    /usr/pgsql-12/bin/postgresql-12-check-db-dir ${PGDATA}

    if [ $? -ne 0 ]; then
        # fix directory permissions
        chown postgres:postgres ${PGDATA}
        su - postgres -c "/usr/pgsql-12/bin/initdb ${PGDATA}"

        if [ $? -ne 0 ]; then
            echo "Cannot init PGDATA=${PGDATA}"
            exit 1
        fi
    fi

    su - postgres -c "/usr/pgsql-12/bin/postmaster -D ${PGDATA}"
else
    $@
fi