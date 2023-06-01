# Using two stage image build
#First stage 
#Get python 3.8 alpine image from repository. Using alpine because of size
FROM python:3.8-alpine as builder

#Updating and installing neccesssary packages for installing dependencies in Alpine linux
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev

#Copying requirements.txt from local dir to inside of container
COPY requirements.txt requirements.txt

#Upgrading pip
RUN pip install --upgrade pip

#Installing all dependecies
RUN pip install --no-cache-dir --requirement requirements.txt

#Second stage 
FROM python:3.8-alpine

#Declare env variables
ENV FLASK_APP=src/app.py
ENV APP_HOME=/app 

#Adding user
RUN adduser -S app

#Choosing work dir where we will work then
WORKDIR $APP_HOME

#Updating alpine and copying all neccessary files from previous stage(builder)
RUN apk update && apk add libpq
COPY --from=builder /usr/local/lib/python3.8/site-packages/ /usr/local/lib/python3.8/site-packages/
COPY --from=builder /usr/local/bin/ /usr/local/bin/    

#Copying all files from local to container
COPY . .

RUN chown -R app $APP_HOME
#By default container run in root. Here I change root -> new user (app)
USER app

#Executing script inside workdir
ENTRYPOINT ["sh","./docker-entrypoint.sh"]
