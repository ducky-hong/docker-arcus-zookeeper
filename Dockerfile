FROM java:7

ADD . /opt
RUN set -x && cd /opt && tar xzf zookeeper-3.4.5.tar.gz && mv /opt/zookeeper-3.4.5 /usr/local/zookeeper && cd /usr/local/zookeeper && cp conf/zoo_sample.cfg conf/zoo.cfg

EXPOSE 2181
CMD ["/usr/local/zookeeper/bin/zkServer.sh", "start-foreground"]
