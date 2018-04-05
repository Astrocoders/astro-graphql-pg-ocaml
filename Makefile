JBUILDER ?= jbuilder

all:
	$(JBUILDER) build @install @DEFAULT

clean:
	rm -rf _build

deps:
	opam install jbuilder
	opam install utop 
	opam install merlin
	opam install ocp-indent
	opam install graphql-lwt

.PHONY: clean all
