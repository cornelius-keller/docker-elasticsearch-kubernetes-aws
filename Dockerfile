FROM quay.io/pires/docker-elasticsearch-kubernetes:2.1.0

COPY do-not-use.yml /

RUN mv /elasticsearch/config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml.bkup && \
    mv do-not-use.yml /elasticsearch/config/elasticsearch.yml && \
    /elasticsearch/bin/plugin install cloud-aws && \
    /elasticsearch/bin/plugin install lmenezes/elasticsearch-kopf/2.X && \
    /elasticsearch/bin/plugin install delete-by-query && \
    mv /elasticsearch/config/elasticsearch.yml.bkup /elasticsearch/config/elasticsearch.yml

RUN mv /run.sh /run-without-secrets.sh

COPY run.sh /
RUN chmod a+x /run.sh
