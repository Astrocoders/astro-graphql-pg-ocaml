
JBUILDER ?= jbuilder

all:
	$(JBUILDER) build @install @DEFAULT

clean:
	rm -rf _build

.PHONY: clean all
