FROM registry.access.redhat.com/ubi8/ubi-minimal:8.2

ARG cnb_uid=1001
ARG cnb_gid=0

RUN microdnf install -y shadow-utils tar

# Create user and add to root group
RUN useradd -u ${cnb_uid} -g ${cnb_gid} -s /bin/bash cnb

# Set required CNB information
ENV CNB_USER_ID=${cnb_uid}
ENV CNB_GROUP_ID=${cnb_gid}