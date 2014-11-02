class Noir::Command::New::Makefile::Tex < Noir::Base::TerminalCommand
  @description = 'Create new Makefile for TeX'

  MakefileText = %q(
# target name
TARGET=<tex_file_name_without_extension>

# dependencies
$(TARGET).pdf : $(TARGET).dvi
	dvipdfmx $<

$(TARGET).dvi : $(wildcard **/*.tex) $(TARGET).tex
	platex $(TARGET).tex
	platex $(TARGET).tex
	platex $(TARGET).tex


# commands
.PHONY : clean all open remake

clean:
	rm -f *.dvi *.aux *.log *.pdf *.ps *.gz *.bbl *.blg *.toc *~ *.core *.cpt

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

