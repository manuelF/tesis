PLOTS=$(wildcard plots/comun/*.py)


tesis.pdf: *.tex bibliografia.bib plots
	pdflatex tesis.tex
	bibtex tesis.aux
	pdflatex tesis.tex
	pdflatex tesis.tex

plots: $(PLOTS)
	bash regenerate_plots.sh
	touch plots

clean: cleantex cleanplots

cleanplots:
	find plots/ -name *.png | xargs rm -f
cleantex:
	rm -f tesis.pdf *.aux *.toc *.log *.out *.idx *.bbl *.bcf *.blg
