FROM ocaml/opam:alpine
RUN opam switch 4.04.2 && eval `opam config env`
RUN opam depext jbuilder opium
RUN opam install jbuilder opium
ADD . .
RUN opam config exec make build

FROM alpine
WORKDIR /app
COPY --from=0 /home/opam/_build/default/bin/haversiner.exe .
EXPOSE 3000
CMD ./haversiner.exe
