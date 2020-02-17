docker build -t speechlab.azurecr.io/sclite-scoring-debian:1.0 -f Dockerfile_sclite_debian . 



>> Logs:
Sending build context to Docker daemon  33.14MB

Step 1/15 : FROM debian:9
 ---> 5c43e435cc11
Step 2/15 : MAINTAINER Ly <tlvu@ntu.edu.sg>
 ---> Using cache
 ---> 45fd4ed8ef59
Step 3/15 : LABEL Description="Docker file for sclite - part of NIST Speech Recognition Scoring Toolkit (SCTK)"
 ---> Using cache
 ---> b3934edb2d93
Step 4/15 : ENV TZ Asia/Singapore
 ---> Using cache
 ---> de47198df4fd
Step 5/15 : ENV TINI_VERSION v0.18.0
 ---> Using cache
 ---> d43e8dd65923
Step 6/15 : ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini

 ---> Using cache
 ---> 4d6e86119c7e
Step 7/15 : RUN chmod +x /tini
 ---> Using cache
 ---> 0fe687147e52
Step 8/15 : RUN apt-get update &&     apt-get install -y autoconf automake bzip2 g++ git make swig gzip gawk &&     apt-get clean autoclean &&     apt-get autoremove -y
 ---> Using cache
 ---> d55f983fdfdd
Step 9/15 : WORKDIR /workspace
 ---> Using cache
 ---> 1b0794532d18
Step 10/15 : RUN git clone https://github.com/usnistgov/SCTK.git &&     cd /workspace/SCTK/ && make config && make all && make check && make install && make doc &&     echo 'export PATH='"$(pwd)/bin"':$PATH' >> $HOME/.bashrc
 ---> Using cache
 ---> fc13c65cc8ac
Step 11/15 : RUN /bin/bash -c "source ~/.bashrc"
 ---> Using cache
 ---> fe287be4c0a4
Step 12/15 : RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/*     && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
 ---> Using cache
 ---> 4c1b51726773
Step 13/15 : COPY score.sh            /workspace/
 ---> Using cache
 ---> 2f3bbdb66f0c
Step 14/15 : RUN  chmod +x /workspace/score.sh
 ---> Using cache
 ---> 6a500afdb95f
Step 15/15 : ENTRYPOINT ["/tini", "--"]
 ---> Using cache
 ---> 16425415e7c7
Successfully built 16425415e7c7
Successfully tagged speechlab.azurecr.io/sclite-scoring-debian:1.0

