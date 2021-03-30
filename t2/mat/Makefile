octave.log: rc.m
	sed -i 's/C =/Ca = /g' data.txt
	octave $< > $@
	mv data_sim.txt ~/ist-tcfe/t2/sim
	
	sed -i 's/\=/\&/g' nodal_tab.tex
	sed -i 's/$$/\\\\ \\hline/g' nodal_tab.tex
	sed -i 's/\_//g' nodal_tab.tex
	mv nodal_tab.tex ~/ist-tcfe/t2/doc
clean:
	@rm -f octave.log octave-workspace *.eps *~
	@rm -f data.txt
	@rm -f nodal_tab.tex
	
.PHONY: clean
