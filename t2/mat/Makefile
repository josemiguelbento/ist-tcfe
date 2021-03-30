octave.log: rc.m
	sed -i 's/C =/Ca = /g' data.txt
	octave $< > $@
	mv data_sim.txt ~/ist-tcfe/t2/sim
clean:
	@rm -f octave.log octave-workspace *.eps *~
	@rm -f data.txt
	
.PHONY: clean
