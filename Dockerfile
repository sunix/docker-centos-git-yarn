FROM centos

# Add yarn repo
RUN curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
# Install nodejs/npm/yarn
RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -

RUN yum install -y epel-release && yum install -y git nodejs sudo make yarn gcc-c++ unzip jq expect

RUN mkdir -p /home/user && \
    chgrp -R 0 /home/user && \
    chmod -R g=u /home/user
RUN chmod g=u /etc/passwd
ADD uid_entrypoint /uid_entrypoint
RUN chmod u+x /uid_entrypoint
ENTRYPOINT [ "/uid_entrypoint" ]
USER 1001
ENV HOME=/home/user
CMD tail -f /dev/null
