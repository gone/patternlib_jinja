#!/bin/bash

#TODO: This doesn't handle test databases correctly
RESULT=`psql -l | grep "sampleapp" | wc -l | awk '{print $1}'`;
if test $RESULT -eq 0; then
    echo "Creating Database";
    psql -c "create role sampleapp with createdb encrypted password 'sampleapp' login;"
    psql -c "alter user sampleapp superuser;"
    psql -c "create database sampleapp with owner sampleapp;"
else
    echo "Database exists"
fi

#run initial setup of database tables
poetry run python manage.py migrate
