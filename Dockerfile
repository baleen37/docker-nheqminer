FROM nvidia/cuda:9.0-devel

RUN apt-get update -y -qq \
  && apt-get install -y -qq cmake libboost-all-dev git
