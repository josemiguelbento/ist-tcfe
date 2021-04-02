octave.log: rc.m
	sed -i 's/C =/Ca = /g' data.txt
	octave $< > $@
	mv data_sim.txt ~/ist-tcfe/t2/sim
	mv data_simeq.txt ~/ist-tcfe/t2/sim
	mv data_sim3.txt ~/ist-tcfe/t2/sim
	mv data_sim4.txt ~/ist-tcfe/t2/sim
	mv data_sim5.txt ~/ist-tcfe/t2/sim
	
	sed -i 's/\=/\&/g' nodal_tab.tex
	sed -i 's/$$/\\\\ \\hline/g' nodal_tab.tex
	sed -i 's/\_//g' nodal_tab.tex
	mv nodal_tab.tex ~/ist-tcfe/t2/doc
	
	sed -i 's/\=/\&/g' phaser_tab.tex
	sed -i 's/p//g' phaser_tab.tex
	sed -i 's/$$/\\\\ \\hline/g' phaser_tab.tex
	mv phaser_tab.tex ~/ist-tcfe/t2/doc
	
	sed -i 's/\=/\&/g' req_tab.tex
	sed -i 's/$$/\\\\ \\hline/g' req_tab.tex
	sed -i 's/eq//g' req_tab.tex
	sed -i 's/R/Req/g' req_tab.tex
	sed -i 's/tau/\\tau/g' req_tab.tex
	mv req_tab.tex ~/ist-tcfe/t2/doc
	
	mv *.odg ~/ist-tcfe/t2/doc

clean:
	@rm -f octave.log octave-workspace *.eps *~
	@rm -f data*
	@rm -f *_tab.tex
	
.PHONY: clean
