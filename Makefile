GHDL_ARGS=-fsynopsys --std=08
GHDL_WORK=tg68kdotc


tg68kdotc.v: TG68K_ALU.vhd  TG68KdotC_Kernel.vhd  TG68K_Pack.vhd  TG68K.vhd tg68dotc_verilog_wrapper.vhd
	rm -rf build
	mkdir build
	ghdl -i $(GHDL_ARGS) --work=$(GHDL_WORK) --workdir=build -Pbuild \
	TG68K_ALU.vhd  TG68KdotC_Kernel.vhd  TG68K_Pack.vhd  TG68K.vhd \
	tg68dotc_verilog_wrapper.vhd

	ghdl -m $(GHDL_ARGS) --work=$(GHDL_WORK) --workdir=build tg68kdotc_verilog_wrapper

	ghdl synth $(GHDL_ARGS) --work=$(GHDL_WORK) --workdir=build -Pbuild \
	--out=verilog tg68kdotc_verilog_wrapper > $@

.PHONY: test
test: tg68kdotc.v
	verilator -cc --report-unoptflat $<
