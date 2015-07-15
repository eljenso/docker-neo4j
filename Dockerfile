FROM java:7-jdk
MAINTAINER Jens Böttcher <eljenso.boettcher@gmail.com>

# Install and configure Neo4j 2.2.3
RUN cd /tmp && \
    wget http://dist.neo4j.org/neo4j-community-2.2.3-unix.tar.gz && \
    tar xzvf neo4j-community-2.2.3-unix.tar.gz && \
    mv /tmp/neo4j-community-2.2.3/ /neo4j && \
    sed -e 's/^org.neo4j.server.database.location=.*$/org.neo4j.server.database.location=\/data\/graph.db/' -i /neo4j/conf/neo4j-server.properties && \
    sed -e 's/^#org.neo4j.server.webserver.address=.*$/org.neo4j.server.webserver.address=0.0.0.0/' -i /neo4j/conf/neo4j-server.properties && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add scripts
ADD scripts /scripts
RUN chmod +x /scripts/*.sh

# Command to run
ENTRYPOINT ["/scripts/run.sh"]
CMD [""]

# Expose listen port
EXPOSE 7474

# Expose our data volumes
VOLUME ["/data"]
