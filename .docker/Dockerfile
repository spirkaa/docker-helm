# hadolint global ignore=DL3006,DL3018

ARG BUILD_IMAGE=alpine:3.18

FROM ${BUILD_IMAGE}

ARG CURL="curl -fsSL"

SHELL [ "/bin/ash", "-euxo", "pipefail", "-c" ]
WORKDIR /usr/local/bin

RUN apk add --update --no-cache \
        bash \
        curl \
        jq

RUN YQ_VERSION="$(${CURL} -o /dev/null -w %\{url_effective\} https://github.com/mikefarah/yq/releases/latest | sed 's/^.*\///g' )" \
    && ${CURL} "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64.tar.gz" | tar xzO ./yq_linux_amd64 > yq \
    && chmod +x yq \
    && yq --version | grep -E "${YQ_VERSION}"

RUN HELM_VERSION="$(${CURL} -o /dev/null -w %\{url_effective\} https://github.com/helm/helm/releases/latest | sed 's/^.*\///g' )" \
    && ${CURL} "https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz" | tar xzO linux-amd64/helm > helm \
    && chmod +x helm \
    && helm version | grep -E "${HELM_VERSION}"

WORKDIR /

CMD [ "/bin/bash" ]
