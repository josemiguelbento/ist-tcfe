# ---------------------------------------------------------
# type the "make" command to create report.pdf 
# ---------------------------------------------------------

#doc name
FILE=report

#list of LibreOffice Draw files 
LODFIGS = $(patsubst %.odg,%.pdf,$(wildcard *.odg))

all: $(FILE).pdf
#	mogrify -format pdf -- *jpg
	evince $< &
	

$(FILE).pdf: $(wildcard *.tex) $(LODFIGS)
	pdflatex  $(FILE).tex
	pdflatex  $(FILE).tex
	pdflatex  $(FILE).tex
	pdflatex  $(FILE).tex


#convert libreoffice draw figures to pdf
%.pdf: %.odg
	soffice --headless --convert-to pdf $<

clean:
	@rm -rf *.aux *.bbl *.blg *.glg *.glo *.gls *.ilg *.ist *.lof
	@rm -rf *.log *.lot *.nlo *.nls *.out *.toc *~ *.*% ./*.pdf ./*.eps
	@rm -f *_tab.tex
	@rm -f *_tab.odg
	@rm -f gain_octave.odg 
	@rm -f merit.tex 
	@rm -f op.tex 
	@rm -f values.tex
.PHONY: all clean


