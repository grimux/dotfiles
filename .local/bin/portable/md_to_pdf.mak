CC=pandoc
MK=$(wildcard *.md)
PDF=$(MK:.md=.pdf)
FLAG=-s -t html5 --css $(GITCSS) -o

all: $(PDF)

$(PDF): %.pdf : %.md
	$(CC) $< $(FLAG) $@

.PHONY: clean

clean:
	@echo "Cleaning up..."
	rm -f $(PDF)
