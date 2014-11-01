
tesis.pdf: *.tex bibliografia.bib
	pdflatex tesis.tex
	bibtex tesis.aux
	pdflatex tesis.tex
	pdflatex tesis.tex

plots:
	bash regenerate_plots.sh

clean: cleantex cleanplots

cleanplots:
	find plots/ -name *.png | xargs rm -f
cleantex:
	rm -f tesis.pdf *.aux *.toc *.log *.out *.idx *.bbl *.bcf *.blg

install:
	pip install numpy matplotlib scipy pandas seaborn

.PHONY: clean cleantex cleanplots plots
