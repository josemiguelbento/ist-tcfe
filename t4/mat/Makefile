all: octave.log
#	mv all_vout.eps ../doc
#	mv deviation.eps ../doc
#	mv envelope.eps ../doc
#	mv regulator.eps ../doc

octave.log: t4.m
	octave $< > $@
	octave t4_freq_resp.m > octave_freq_resp.log
	mv gain_octave.odg ../doc


clean:
	@rm -f octave.log octave-workspace *.eps *~ *.odg
	@rm -f data*
	@rm -f *_tab.tex result_octave.txt result_octave_lco_uco.txt operating_point.txt
	
.PHONY: clean
