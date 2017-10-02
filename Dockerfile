FROM ocaml/opam:alpine
WORKDIR haversiner
ADD haversiner.opam .
RUN opam pin add -yn haversiner . && \
    opam depext haversiner && \
    opam install --deps-only haversiner
ADD . .
RUN sudo chown -R opam:nogroup . && \
    opam config exec make build && \
    opam depext -ln haversiner | egrep -o "\-\s.*" | sed "s/- //" > depexts

FROM alpine
WORKDIR /app
COPY --from=0 /home/opam/haversiner/_build/default/bin/main.exe haversiner.exe
COPY --from=0 /home/opam/haversiner/depexts depexts
RUN cat depexts | xargs apk --update add && rm -rf /var/cache/apk/*
EXPOSE 3000
CMD ./haversiner.exe
