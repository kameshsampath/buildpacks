FROM registry.access.redhat.com/ubi8/ubi:8.2

ARG cnb_uid=1001
ARG cnb_gid=0

# Create user and add it to root group
RUN useradd -u ${cnb_uid} -g ${cnb_gid} -s /bin/bash cnb

# Set required CNB information
ENV CNB_USER_ID=${cnb_uid}
ENV CNB_GROUP_ID=${cnb_gid}