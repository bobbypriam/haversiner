FROM ocaml/opam:alpine
WORKDIR haversiner
ADD haversiner.opam .
RUN opam pin add -yn haversiner . && \
    opam depext haversiner && \
    opam install --deps-only haversiner
ADD . .
RUN sudo chown -R opam:nogroup . && \
    opam config exec make build

FROM alpine
WORKDIR /app
COPY --from=0 /home/opam/haversiner/_build/default/bin/main.exe haversiner.exe
EXPOSE 3000
CMD ./haversiner.exe
