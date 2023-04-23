.PHONY: all clean

all: main.pdf

main.pdf: bib.bib main.tex preamble.fmt softdev.sty
	pdflatex -interaction=nonstopmode -halt-on-error -file-line-error main.tex
	bibtex main
	pdflatex -interaction=nonstopmode -halt-on-error -file-line-error main.tex
	pdflatex -interaction=nonstopmode -halt-on-error -file-line-error main.tex

clean:
	rm -f *.aux *.log *.pdf

preamble.fmt: preamble.tex softdev.sty
	set -e; \
	  tmptex=`mktemp`; \
	  cat ${@:fmt=tex} > $${tmptex}; \
	  grep -v "%&${@:_preamble.fmt=}" ${@:_preamble.fmt=.tex} >> $${tmptex}; \
	  pdftex -ini -jobname="${@:.fmt=}" "&pdflatex" mylatexformat.tex $${tmptex}; \
	  rm $${tmptex}

bib.bib: softdevbib/softdev.bib local.bib
	softdevbib/bin/prebib -x month softdevbib/softdev.bib > bib.bib
	softdevbib/bin/prebib -x month local.bib >> bib.bib

softdevbib/softdev.bib:
	git submodule init
	git submodule update
