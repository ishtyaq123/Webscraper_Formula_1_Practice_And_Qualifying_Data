FROM python:3.8-slim-buster

COPY . .

RUN set -xe 
RUN apt-get update
RUN apt-get install -y gnupg2 
RUN apt-get install -y wget 
RUN apt-get install -y curl 

#Adding trusting keys to apt for repositories
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

#Adding Google Chrome to the repos
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

#updating apt
RUN apt-get -y update

#intstalling google chrome
RUN apt-get install -y google-chrome-stable

#updating google chrome
RUN apt-get -y update

#installing unzip
RUN apt-get install -yqq unzip

#dowloading the zip file containing the latest chromedriver
#RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip

#dowloading the zip file containing the latest chromedriver
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/94.0.4606.61/chromedriver_linux64.zip

#unzip the chrome driver
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

RUN pip install -r ./requirements.txt

ENV DISPLAY=:99

CMD ["python", "-m", "Scraper"]