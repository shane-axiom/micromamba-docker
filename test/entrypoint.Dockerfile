ARG BASE_IMAGE=micromamba:test-debian-bullseye-slim

FROM $BASE_IMAGE
RUN micromamba install -y -n base -c conda-forge \
       python=3.9.1  && \
    micromamba clean --all --yes

ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "python"]
