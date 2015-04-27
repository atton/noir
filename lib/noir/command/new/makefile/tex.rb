class Noir::Command::New::Makefile::Tex < Noir::Base::TerminalCommand
  @description = 'Create new Makefile for TeX'

  MakefileText = %q(
# Settings
TARGET=<`1:filename_without_extension`>
BIBTEX=echo # pbibtex
BB=extractbb

vpath pdf fig
FIGURES=$(wildcard fig/*.pdf)
FIGURES_FOR_TEX=$(subst .pdf,.xbb,$(FIGURES))

# dependencies
$(TARGET).pdf : $(TARGET).dvi
	dvipdfmx $<

$(TARGET).dvi : $(wildcard *.tex) $(FIGURES_FOR_TEX) $(SOURCES_FOR_TEX)
	platex  $(TARGET).tex
	$(BIBTEX) $(TARGET)
	platex  $(TARGET).tex
	platex  $(TARGET).tex

%.xbb: %.pdf
	$(BB) $<


# commands
.PHONY : clean all open remake

clean:
	rm -f *.dvi *.aux *.log *.pdf *.ps *.gz *.bbl *.blg *.toc *~ *.core *.cpt *.lof *.lot *.lol *.bbl *.blg

all: $(TARGET).pdf

open: $(TARGET).pdf
	open $(TARGET).pdf

remake:
	make clean
	make all
)

  def self.execute *args
    Noir::Command::New::Makefile.createMakefile MakefileText
  end

end

