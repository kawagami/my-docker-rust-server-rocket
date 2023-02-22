FROM rust:1.67.1 AS builder

WORKDIR app

COPY src /app/src

COPY Cargo.toml .

RUN cargo build --release


FROM debian:buster-slim as runner

COPY --from=builder /app/target/release/rocket-server /app/rocket-server

EXPOSE 8000

# https://stackoverflow.com/a/46203897
ENV ROCKET_ADDRESS=0.0.0.0

CMD ["/app/rocket-server"]
