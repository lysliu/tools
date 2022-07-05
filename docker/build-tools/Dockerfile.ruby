
#############
# Ruby
#############

FROM ubuntu:focal as ruby_tools_context

ENV DEBIAN_FRONTEND=noninteractive

# Pinned versions of stuff we pull in
ENV AWESOMEBOT_VERSION=1.20.0
# Sometime between 1.14.1 and 1.14.2 to pull in some fixes for deb
ENV FPM_VERSION=eb5370d16e361db3f1425f8c898bafe7f3c66869
ENV HTMLPROOFER_VERSION=3.19.0
ENV LICENSEE_VERSION=9.15.1
ENV MDL_VERSION=0.11.0

# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    gnupg2 \
    software-properties-common \
    build-essential \
    zlib1g-dev \
    cmake \
    pkg-config \
    libssl-dev \
    git

# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
    ruby2.7 \
    ruby2.7-dev

# Install istio.io verification tools
RUN gem install --no-wrappers --no-document mdl -v ${MDL_VERSION}
RUN gem install --no-wrappers --no-document html-proofer -v ${HTMLPROOFER_VERSION}
RUN gem install --no-wrappers --no-document awesome_bot -v ${AWESOMEBOT_VERSION}
RUN gem install --no-wrappers --no-document licensee -v ${LICENSEE_VERSION}
# hadolint ignore=DL3003,DL3028
RUN git clone https://github.com/jordansissel/fpm && \
    cd fpm && \
    git reset --hard ${FPM_VERSION} && \
    make install

