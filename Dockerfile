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

# Define mountable directories.
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Define working directory.
WORKDIR /elasticsearch

ENV ES_JAVA_OPTS -Xms512m -Xmx512m

#Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300