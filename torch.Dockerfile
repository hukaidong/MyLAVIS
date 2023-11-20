# syntax=docker/dockerfile:1.4

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked <<-EOT
  apt-get update
  apt-get install -y python3-pip libglib2.0-0
EOT

COPY . /lavis
  
RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked <<-EOT
  cd /lavis
  pip3 install --upgrade pip
  pip3 install -e .
  pip3 install jupyterlab
EOT
