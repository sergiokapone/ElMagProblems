set table "EMProblems.curve.table"; set format "%.5f"
set isosamples 55, 55; set contour base; set cntrparam levels incremental -2,0.4,2; unset surface; splot [-4:4] [-2.2:2.2] (y*(1+0.57143/(x**2 + y**2))) ;
