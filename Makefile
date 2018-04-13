JBUILDER ?= jbuilder

all:
	$(JBUILDER) build @install @DEFAULT

clean:
	rm -rf _build

deps:
	opam install jbuilder.1.0+beta16
	opam install utop.2.0.2
	opam install merlin.3.0.5
	opam install ocp-indent.1.6.1
	opam install graphql-lwt.0.3.0
	opam pin add ezpostgresql https://github.com/bobbypriambodo/ezpostgresql.git

.PHONY: clean all
