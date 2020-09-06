ElasticSearch 7.9.1 for raspberry pi 4.

Before start you need start vm.max.sh or

`sudo sysctl -w vm.max_map_count=262144`

Build image

`docker build -t elasticsearch .`

Run image

`docker run -d --restart=unless-stopped --name=elasticsearch -p 9200:9200 -p 9300:9300 --name elasticsearch -v /data:/elasticsearch/data elasticsearch`
