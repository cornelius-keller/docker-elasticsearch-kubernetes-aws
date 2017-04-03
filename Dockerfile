FROM quay.io/pires/docker-elasticsearch-kubernetes:2.4.0

COPY do-not-use.yml /

RUN mv /elasticsearch/config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml.bkup && \
    mv do-not-use.yml /elasticsearch/config/elasticsearch.yml && \
    /elasticsearch/bin/plugin install cloud-aws && \
    /elasticsearch/bin/plugin install lmenezes/elasticsearch-kopf/2.X && \
    /elasticsearch/bin/plugin install delete-by-query && \
    /elasticsearch/bin/plugin install https://github.com/vvanholl/elasticsearch-prometheus-exporter/releases/download/2.4.0.0/elasticsearch-prometheus-exporter-2.4.0.0.zip && \
    mv /elasticsearch/config/elasticsearch.yml.bkup /elasticsearch/config/elasticsearch.yml

RUN mv /run.sh /run-without-secrets.sh

RUN grep -q -F 'script.engine.groovy.inline.update: on' /elasticsearch/config/elasticsearch.yml || echo 'script.engine.groovy.inline.update: on' >> /elasticsearch/config/elasticsearch.yml

COPY run.sh /
RUN chmod a+x /run.sh
