#include "mex.h"
//#include "matrix.h"
void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
	if(nrhs != 1) mexErrMsgTxt("Expecting exactly one input argument.");
	if(nlhs > 1) mexErrMsgTxt("Expecting exactly one output argument.");
	if(!mxIsDouble(prhs[0])) mexErrMsgTxt("Expecting first argument to be a real-valued symmetric matrix.");
	if(mxGetM(prhs[0]) != mxGetN(prhs[0])) mexErrMsgTxt("Expecting input matrix to be symmetric.");
	plhs[0] = mxDuplicateArray(prhs[0]);
	size_t N = mxGetN(plhs[0]);
	double * d = mxGetPr(plhs[0]);
	for(int k = 0;k < N;k++) for(int i = 0;i < N;i++) for(int j = 0;j < N;j++) {
		d[i*N+j] = min(d[i*N+j],d[i*N+k] + d[k*N+j]);
	}
}
