FROM sonatype/nexus3:3.65.0

# Set working directory
WORKDIR /opt/sonatype/nexus

# Remove unwanted repository formats to reduce startup overhead
RUN rm -rf system/org/sonatype/nexus/plugins/nexus-docker* \
           system/org/sonatype/nexus/plugins/nexus-npm* \
           system/org/sonatype/nexus/plugins/nexus-yum* \
           system/org/sonatype/nexus/plugins/nexus-rubygems* \
           system/org/sonatype/nexus/plugins/nexus-p2* \
           system/org/sonatype/nexus/plugins/nexus-nuget* \
           system/org/sonatype/nexus/plugins/nexus-helm* \
           system/org/sonatype/nexus/plugins/nexus-cocoapods* \
           system/org/sonatype/nexus/plugins/nexus-go* \
           system/org/sonatype/nexus/plugins/nexus-cargo* \
           system/org/sonatype/nexus/plugins/nexus-clojars*

# Optional: remove font packages and docs (minor gain)
RUN rm -rf public/static/fonts \
           public/docs

# Expose default Nexus port
EXPOSE 8081

# Default start command
CMD ["/opt/sonatype/nexus/bin/nexus", "run"]