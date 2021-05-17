#!/bin/bash
# ------------------------------------------------------------
# type "make" command in the Linux terminal create report.pdf
#
# type "make clean" to delete all generated files
# ------------------------------------------------------------

all:	
	octave data_gen.m
	mv data_t4.txt ./sim
	make -C mat
	make -C sim
	octave eval_sim.m
#	sed -i 's/$$/\\\\ \\hline/g' merit.tex
#	mv merit.tex ./doc
#	make -C doc
#	cp doc/report.pdf .

clean:
	@rm -f data_octave.txt data_t3.txt merit.tex report.pdf data_t4.txt
	make -C mat clean
	make -C sim clean
	make -C doc clean

.PHONY: all clean

