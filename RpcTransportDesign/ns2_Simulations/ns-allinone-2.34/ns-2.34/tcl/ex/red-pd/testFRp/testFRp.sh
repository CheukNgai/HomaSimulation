#! /bin/csh

rm -f testFRp/flows* testFRp/tmp* testFRp/dropRate* testFRp/data*

set t1=1000
foreach p ( 0.01 0.02 0.03 0.04 0.05)
	echo "Doing drop rate ${p}"
	foreach rate ( 0.25 0.5 0.75 1.0 1.25 1.5 1.75 2.0 3.0 4.0 5.0 )
		echo "Doing gamma ${rate}"
		ns red-pd.tcl one netTestFRp TestFRp p ${p} gamma ${rate} ftype cbr testUnresp 0 verbose -1 time $t1
		mv one.netTestFRp.TestFRp.1.flows flows-${p}-${rate}
	end
	testFRp/testFRp.pl flows-${p} ${p} $t1 > data-${p}
end

mv flows-* data-* testFRp
cd testFRp
gnuplot testFRp.gp
gv testFRp.ps &

cd ..

