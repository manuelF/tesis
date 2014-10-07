tesis.pdf: *.tex bibliografia.bib
	pdflatex tesis.tex
	bibtex tesis.aux
	pdflatex tesis.tex
	pdflatex tesis.tex

clean:
	rm -f tesis.pdf *.aux *.toc *.log *.out *.idx *.bbl *.bcf *.blg
