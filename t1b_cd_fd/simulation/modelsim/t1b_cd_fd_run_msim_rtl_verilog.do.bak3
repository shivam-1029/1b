transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/shiva/Downloads/Desktop/eb_2478_task1b/t1b_cd_fd/code {C:/Users/shiva/Downloads/Desktop/eb_2478_task1b/t1b_cd_fd/code/t1b_cd_fd.v}

vlog -vlog01compat -work work +incdir+C:/Users/shiva/Downloads/Desktop/eb_2478_task1b/t1b_cd_fd/.test {C:/Users/shiva/Downloads/Desktop/eb_2478_task1b/t1b_cd_fd/.test/tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb

add wave *
view structure
view signals
run 10 ms
