FROM java:7

RUN apt-get update \
        && apt-get install -y --no-install-recommends python-pip \
        && pip install kazoo \
        && apt-get clean

COPY . /opt
RUN set -x && cd /opt && tar xzf zookeeper-3.4.5.tar.gz \
        && mv /opt/zookeeper-3.4.5 /usr/local/zookeeper \
        && cd /usr/local/zookeeper \
        && cp conf/zoo_sample.cfg conf/zoo.cfg

EXPOSE 2181

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["/usr/local/zookeeper/bin/zkServer.sh", "start-foreground"]
