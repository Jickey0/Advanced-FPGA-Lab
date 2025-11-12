set ModuleHierarchy {[{
"Name" : "matrix_mult", "RefName" : "matrix_mult","ID" : "0","Type" : "dataflow",
"SubInsts" : [
	{"Name" : "Loop_row_proc_U0", "RefName" : "Loop_row_proc","ID" : "1","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "row_col","RefName" : "row_col","ID" : "2","Type" : "pipeline"},]},]
}]}