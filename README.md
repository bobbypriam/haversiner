# Haversiner

A simple OCaml app for calculating great-circle distance between two coordinates using the [Haversine formula](https://en.wikipedia.org/wiki/Haversine_formula), powered by [Opium](https://github.com/rgrinberg/opium).

## Development

Clone this repo, then:

```
$ opam install jbuilder opium ounit
$ make run
```

The server will then run on http://localhost:3000. Try it with:

```
$ curl -XPOST http://localhost:3000 -d @test/payload.json
{"distance":2886.444442837984}
```

See [test/payload.json](test/payload.json) for example payload.
