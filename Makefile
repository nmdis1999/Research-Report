.SUFFIXES: .ltx .pdf

all: main.pdf

clean:
	rm -f *.aux *.log *.pdf
	rm -rf main.log main.bbl main.blg main.aux main.pdf main.out main_preamble.fmt

main.pdf: local.bib main.ltx main_preamble.fmt
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

