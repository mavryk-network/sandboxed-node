FROM alpine:3.19
WORKDIR /mavryk
RUN wget "https://raw.githubusercontent.com/zcash/zcash/v5.6.0/zcutil/fetch-params.sh" \
  && export OSTYPE=linux \
  && sed '/SAPLING_SPROUT_GROTH16_NAME/d; /progress/d; /retry-connrefused/d' fetch-params.sh | sh \
  && rm fetch-params.sh

# `fetch-params.sh` is not available since v5.7.0!
# RUN mkdir /root/.zcash-params \
#   && wget "https://download.z.cash/downloads/sprout-groth16.params" -O "/root/.zcash-params/sprout-groth16.params"

ARG TARGETPLATFORM
ARG TAG
RUN if [ "$TARGETPLATFORM" = "linux/arm64" ]; then EXEC_NAME="mavkit-node-arm64"; else EXEC_NAME="mavkit-node"; fi \
  && wget "https://github.com/mavryk-network/mavryk-packaging/releases/download/$TAG/$EXEC_NAME" -O "mavkit-node" \
  && chmod +x mavkit-node \
  && ln -s mavkit-node mavryk-node
#RUN ./mavryk-node identity generate "0.0" --data-dir /mavryk/sandbox
COPY ./sandbox.json /mavryk/
COPY ./identity.json /mavryk/sandbox/
ENTRYPOINT ["/mavryk/mavkit-node", "run", \
    "-vv", \
    "--data-dir=/mavryk/sandbox", \
    "--synchronisation-threshold=0", \
    "--sandbox=/mavryk/sandbox.json", \
    "--allow-all-rpc=0.0.0.0", \
    "--rpc-addr=0.0.0.0:8732"]