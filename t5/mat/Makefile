all: octave.log
#	mv all_vout.eps ../doc
#	mv deviation.eps ../doc
#	mv envelope.eps ../doc
#	mv regulator.eps ../doc

octave.log: t5.m
	octave $< > $@
	mv teo_gain.eps ../doc
	mv teo_phase.eps ../doc


clean:
	@rm -f octave.log octave-workspace *.eps *~ *.odg
	@rm -f data*
	@rm -f *_tab.tex results_oct.txt result_octave_lco_uco.txt operating_point.txt *.log
	
.PHONY: clean
