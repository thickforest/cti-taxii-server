FROM python:2.7.9
MAINTAINER forest <thickforeset@126.com>

WORKDIR /

#RUN pip install --upgrade pip
RUN pip install supervisor
#RUN apt-get update
#RUN apt-get install -y mongodb-server python-pymongo
#RUN pip install pymongo

RUN mkdir /cti-taxii-server
COPY ./ /cti-taxii-server/
RUN cd /cti-taxii-server \
    && python setup.py install
#&& rm -rf /cti-taxii-server

COPY supervisord.conf /supervisord.conf
EXPOSE 9000
CMD ["supervisord", "-c", "/supervisord.conf"]
