FROM adoptopenjdk:11-jdk-hotspot-bionic

ENV ES_VERSION 7.9.1

RUN apt-get update -y && apt-get install -y wget tar

# Install Elasticsearch.
RUN \
  cd / && \
  wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-$ES_VERSION-linux-x86_64.tar.gz && \
  tar xvzf elasticsearch-oss-$ES_VERSION-linux-x86_64.tar.gz && \
  rm -f elasticsearch-oss-$ES_VERSION-linux-x86_64.tar.gz && \
  mv /elasticsearch-$ES_VERSION /elasticsearch

VOLUME ["/elasticsearch/data"]

ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

WORKDIR /elasticsearch

ENV ES_JAVA_OPTS -Xms512m -Xmx512m

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200 9300

CMD ["/elasticsearch/bin/elasticsearch"]