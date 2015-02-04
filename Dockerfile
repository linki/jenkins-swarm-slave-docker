FROM java:7u65

MAINTAINER Carlos Sanchez <carlos@apache.org>

ENV JENKINS_SWARM_VERSION 1.22
ENV HOME /home/jenkins-slave

RUN curl --create-dirs -sSLo /usr/share/jenkins/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/$JENKINS_SWARM_VERSION/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar \
  && chmod 755 /usr/share/jenkins

COPY jenkins-slave.sh /usr/local/bin/jenkins-slave.sh

ENV DOCKER_VERSION 1.5.0

# make sure HTTPS transport is available to APT
RUN apt-get update
RUN apt-get install -y apt-transport-https

# Add the repository to your APT sources
RUN echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list

# Then import the repository key
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

# Install docker
RUN apt-get update
RUN apt-get install -y lxc-docker-$DOCKER_VERSION

VOLUME /home/jenkins-slave
VOLUME /var/run/docker.sock

ENTRYPOINT ["/usr/local/bin/jenkins-slave.sh"]
