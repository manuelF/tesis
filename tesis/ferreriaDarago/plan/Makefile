TARGET=plantesis

$(TARGET).pdf: $(TARGET).tex
	pdflatex $(TARGET).tex
	pdflatex $(TARGET).tex

clean:
	rm -f *.aux *.log *.idx $(TARGET).pdf
