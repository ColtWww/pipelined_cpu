seed = `date +%y%m%d%H%M%S`
top  = tb_top
filelist = filelist.vc 

inst_data ?= "../sim_core/inst_data/rv32ui-p-add.data"

VCS_COM  = -full64 -l vcs.log -sverilog -timescale=1ns/1ps -debug_pp -debug_access+all +error+10000 +vcs+initreg+random +lint=TFIPC-L
VCS_COM += +vcs+lic+wait +plusarg_save +define+GB_SERDES_TIMESCALE=1ns/1fs -fsdb -top ${top} 
VCS_COM += -f ${filelist}

VCS_RUN  = -l sim.log +seed=${seed} +ntb_random_seed=${seed} +vcs+lic+wait +inst_file=${inst_data}


.DEFAULT_GOAL = run
.PHONY: com sim run verdi clean 

com : ${filelist}
	vcs  ${VCS_COM} -cm_dir sim_cov

sim : simv
	simv ${VCS_RUN} -cm_dir sim_cov 

run :  com sim

verdi : ${filelist}
	verdi -sv -full64 ${filelist}  -top ${top} -verditype=off &

clean :
	\rm -rf *.log csrc DVEfiles *.fsdb *.vpd *.conf *.rc simv simv.daidir \
		simv.vdb vdCovLog verdiLog ucli.key *~ 


