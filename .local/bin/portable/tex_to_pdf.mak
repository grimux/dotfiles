CC=pdflatex
SRC=$(wildcard *.tex)
DOC=$(SRC:.tex=.pdf)
JUNK=$(wildcard *.log *.aux)

pdf: $(DOC)

$(DOC): %.pdf : %.tex
	$(CC) $^ -o $@

.PHONY: clean

clean:
	rm -f $(JUNK) $(DOC)
