all: ngspice_auto.log ngspice_auto_inc.log
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
#	$(eval NGSFIGS=$(shell grep _FIG $(word 2,$^) | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
#	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
#	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
#	$(eval NGSTABS=$(shell grep _TAB $(word 2,$^) | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
#	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $(word 2,$^) | grep -v $i_TAB | grep -v $i_END | sed 's/vx#branch/Ix/g'| grep -v '#' | sed 's/v(6)-v(8)/Vx/g' | sed 's/(Vx)\/Ix/Req/g' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	
	mv vp_out.pdf ../doc
	mv vdb_out.pdf ../doc
	mv vout.pdf ../doc
#	mv vrect.pdf ../doc

	
ngspice_auto.log: ../sim/t5.net
	ngspice -b $< -o $@
	
ngspice_auto_inc.log: ../sim/t5_inc.net
	ngspice -b $< -o $@
	
clean:
	@rm -f *.log *.tex *.pdf *.ps *~
	@rm -f *.txt
#	@rm -f vo2f_fig zin_fig zo_inc_fig
.PHONY: all clean
