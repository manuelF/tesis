
tesis.pdf: *.tex bibliografia.bib plots
	pdflatex tesis.tex
	bibtex tesis.aux
	pdflatex tesis.tex
	pdflatex tesis.tex

plots: cleanPlots
	bash regenerate_plots.sh

clean: cleanTex cleanPlots

cleanPlots:
	find plots/ -name *.png | xargs rm -f
cleanTex:
	rm -f tesis.pdf *.aux *.toc *.log *.out *.idx *.bbl *.bcf *.blg
