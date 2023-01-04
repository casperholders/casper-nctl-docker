FROM ubuntu:focal as build-stage

RUN apt-get update \
      && DEBIAN_FRONTEND="noninteractive" \
      apt-get install -y sudo curl git gcc make pkg-config libssl-dev \
      && rm -rf /var/lib/apt/lists/*

# install rust nigthly and rustup
RUN curl -f -L https://static.rust-lang.org/rustup.sh -O \
    && sh rustup.sh -y
ENV PATH="$PATH:/root/.cargo/bin"

RUN git clone -b main https://github.com/casper-ecosystem/casper-client-rs ~/casper-client-rs \
    && cd ~/casper-client-rs && cargo build --release

FROM ubuntu:focal as production-stage

RUN apt-get update \
      && apt-get install -y ca-certificates \
      && rm -rf /var/lib/apt/lists/*

COPY --from=build-stage /root/casper-client-rs/target/release/casper-client ./casper-client

ENTRYPOINT ["./casper-client"]
