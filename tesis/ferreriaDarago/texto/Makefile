
tesis.pdf: *.tex bibliografia.bib doplots
	pdflatex tesis.tex
	bibtex tesis.aux
	pdflatex tesis.tex
	pdflatex tesis.tex

doplots:
	bash regenerate_plots.sh

clean: cleantex cleanplots

cleanplots:
	find plots/ -name *.png | xargs rm -f
cleantex:
	rm -f tesis.pdf *.aux *.toc *.log *.out *.idx *.bbl *.bcf *.blg
