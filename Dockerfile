FROM alpine:3.7

ENV RUNUSER hopm
ENV VERSION 1.1.4
ENV DATADIR /hopm-data
ENV SRCDIR /hopm-src

ARG CONFIGURE_FLAGS="--prefix=/opt/hopm --sysconfdir=$DATADIR/etc --localstatedir=$DATADIR/var"
ARG MAKE_FLAGS=""

RUN set -x \
    && adduser -S $RUNUSER \
    && addgroup -S $RUNUSER \
    && apk add --no-cache --virtual runtime-dependencies \
      su-exec \
      tini \
      build-base \
      openssl-dev \
      curl \
    && mkdir $SRCDIR  && cd $SRCDIR \
    && curl -fsSL "https://netcologne.dl.sourceforge.net/project/ircd-hybrid/hopm/hopm-${VERSION}/hopm-${VERSION}.tgz" -o hopm.tgz \
    && tar xfz hopm.tgz --strip-components=1 \
    && mkdir build && cd build \
    && ls \
    && ../configure $CONFIGURE_FLAGS \
    && make $MAKEFLAGS \
    && make install \
    && cd / && rm -rf $SRCDIR

COPY scripts/entrypoint.sh /
COPY scripts/startup-sequence/* /startup-sequence/

VOLUME /hopm-data

EXPOSE 6667 6697

WORKDIR $DATADIR

ENTRYPOINT ["/entrypoint.sh"]
