FROM amazonlinux:2017.03.1.20170812

ARG work_dir=/tmp/setup
RUN mkdir ${work_dir} && \
    chmod 777 ${work_dir}

# --- install roswell and some common lisp implementations --- #

RUN yum -y install git automake autoconf make gcc bzip2 libcurl curl-devel && \
    cd ${work_dir} && \
    git clone --depth=1 -b release https://github.com/roswell/roswell.git && \
    cd roswell && \
    sh bootstrap && \
    ./configure --disable-manual-install && \
    make && \
    make install && \
    cd .. && \
    rm -rf roswell

RUN ros run -q

RUN ln -s ${HOME}/.roswell/local-projects work
ENV PATH /root/.roswell/bin:${PATH}

RUN yum -y install openssl-devel

RUN ros install ccl-bin/1.11
RUN ros use ccl-bin/1.11

# Assuming whole application directory is mounted as /app
WORKDIR /app/

CMD /bin/sh
