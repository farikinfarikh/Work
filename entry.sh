#!/bin/bash
pip install -r /home/hara/requirements.txt
if [ -z "$AWS_KEY" ]; then
    aws configure set aws_access_key_id $AWS_KEY;
    aws configure set aws_secret_access_key $AWS_SECRET;
    aws configure set region $AWS_REGION;
fi
ls apps | grep -v __* | grep -v __pycache__

#MIGRATION ORDER TO AVOID CONFLICT
python /home/hara/manage.py makemigrations organization
python /home/hara/manage.py migrate organization

python /home/hara/manage.py makemigrations region
python /home/hara/manage.py migrate region

python /home/hara/manage.py makemigrations bumdes
python /home/hara/manage.py migrate bumdes

python /home/hara/manage.py makemigrations userprofile
python /home/hara/manage.py migrate userprofile

python /home/hara/manage.py makemigrations farmer
python /home/hara/manage.py migrate farmer

python /home/hara/manage.py makemigrations cultivation
python /home/hara/manage.py migrate cultivation

python /home/hara/manage.py makemigrations loan
python /home/hara/manage.py migrate loan

python /home/hara/manage.py makemigrations authentication
python /home/hara/manage.py migrate authentication

python /home/hara/manage.py makemigrations form
python /home/hara/manage.py migrate form

python /home/hara/manage.py makemigrations setting
python /home/hara/manage.py migrate setting

python /home/hara/manage.py makemigrations
python /home/hara/manage.py migrate

python /home/hara/manage.py collectstatic --noinput
python /home/hara/manage.py loaddata fixtures/*.json
$CMD