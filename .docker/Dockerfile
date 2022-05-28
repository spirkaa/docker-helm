FROM alpine:3.16

RUN set -eux \
    && apk add --update --no-cache \
        bash \
        curl

RUN set -eux \
    && cd /tmp \
    && HELM_VERSION="$(curl -fsS -L -o /dev/null -w %{url_effective} https://github.com/helm/helm/releases/latest | sed 's/^.*\///g' )" \
    && curl -fsS -L -O https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && tar xvfz helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/bin/helm \
    && chmod +x /usr/bin/helm \
    && rm -rf linux-amd64 helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && helm version | grep -E "${HELM_VERSION}"

CMD [ "/bin/bash" ]
