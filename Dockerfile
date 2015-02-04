FROM java:7u65

MAINTAINER Carlos Sanchez <carlos@apache.org>

ENV JENKINS_SWARM_VERSION 1.22
ENV HOME /home/jenkins-slave

RUN curl --create-dirs -sSLo /usr/share/jenkins/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/$JENKINS_SWARM_VERSION/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar \
  && chmod 755 /usr/share/jenkins

COPY jenkins-slave.sh /usr/local/bin/jenkins-slave.sh

RUN curl -sSL https://get.docker.com/ubuntu/ | sh

VOLUME /home/jenkins-slave
VOLUME /var/run/docker.sock

ENTRYPOINT ["/usr/local/bin/jenkins-slave.sh"]
