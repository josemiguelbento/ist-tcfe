#!/bin/bash
# ------------------------------------------------------------
# type "make" command in the Linux terminal create report.pdf
#
# type "make clean" to delete all generated files
# ------------------------------------------------------------

all:	
	octave data_gen.m
	mv data_t5.txt ./sim
	mv data_t5_inc.txt ./sim
	cp data_octave.txt ./mat
#	make -C mat
	make -C sim
#	octave eval_sim.m
#	sed -i 's/$$/\\\\ \\hline/g' merit.tex
#	mv merit.tex ./doc
#	sed -i 's/$$/\\\\ \\hline/g' op.tex
#	mv op.tex ./doc
#	sed -i 's/$$/\\\\ \\hline/g' valores.tex
#	mv valores.tex ./doc
#	make -C doc
#	cp doc/report.pdf .

clean:
	@rm -f data_octave.txt merit.tex report.pdf data_octave.txt
	make -C mat clean
	make -C sim clean
	make -C doc clean

.PHONY: all clean

