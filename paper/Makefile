paper.pdf: *.tex
	pdflatex paper.tex
	bibtex paper.aux
	pdflatex paper.tex
	pdflatex paper.tex

clean:
	rm -f paper.pdf *.aux *.toc *.log *.out *.idx
