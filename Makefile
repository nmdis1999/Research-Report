.SUFFIXES: .ltx .pdf

all: main.pdf

clean:
	rm -f *.aux *.log *.pdf
	rm -rf main.log main.bbl main.blg main.aux main.pdf main.out main_preamble.fmt

main.pdf: bib.bib main.ltx main_preamble.fmt softdev.sty
	pdflatex main.ltx
	bibtex main
	pdflatex main.ltx
	pdflatex main.ltx

main_preamble.fmt: main_preamble.ltx
	set -e; \
	  tmpltx=`mktemp`; \
	  cat ${@:fmt=ltx} > $${tmpltx}; \
	  grep -v "%&${@:_preamble.fmt=}" ${@:_preamble.fmt=.ltx} >> $${tmpltx}; \
	  pdftex -ini -jobname="${@:.fmt=}" "&pdflatex" mylatexformat.ltx $${tmpltx}; \
	  rm $${tmpltx}

bib.bib: softdevbib/softdev.bib local.bib
	softdevbib/bin/prebib -x month softdevbib/softdev.bib > bib.bib
	softdevbib/bin/prebib -x month local.bib >> bib.bib

softdevbib/softdev.bib:
	git submodule init
	git submodule update
