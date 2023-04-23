.SUFFIXES: .ltx .pdf

all: main.pdf

clean:
	rm -f *.aux *.log *.pdf
	rm -rf main.log main.aux main.pdf main.out 

main.pdf: bib.bib main.ltx preamble.fmt softdev.sty
	pdflatex main.ltx
	bibtex main
	pdflatex main.ltx
	pdflatex main.ltx

preamble.fmt: preamble.ltx softdev.sty

bib.bib: softdevbib/softdev.bib local.bib
	softdevbib/bin/prebib -x month softdevbib/softdev.bib > bib.bib
	softdevbib/bin/prebib -x month local.bib >> bib.bib

softdevbib/softdev.bib:
	git submodule init
	git submodule update
