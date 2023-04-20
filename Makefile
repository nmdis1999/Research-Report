.PHONY: all clean

all: main.pdf

main.pdf: main.tex
	pdflatex -interaction=nonstopmode -halt-on-error -file-line-error main.tex
	pdflatex -interaction=nonstopmode -halt-on-error -file-line-error main.tex

clean:
	rm -f *.aux *.log *.pdf

