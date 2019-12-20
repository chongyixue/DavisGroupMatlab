%coder -build delta_full.prj
cfg = coder.config('mex');
cfg.IntegrityChecks=false;
cfg.ResponsivenessChecks=true;
cfg.SaturateOnIntegerOverflow=false;
cfg.EnableAutoExtrinsicCalls=false;
cfg.GlobalDataSyncMethod='NoSync';

ComplexMatrixType=coder.newtype('double',[inf,inf],'complex',1);
VectorType=coder.newtype('double',[inf,1],'complex',0);
FieldType=coder.newtype('double',[1,1],'complex',0);
CVectorType=coder.newtype('double',[inf,1],'complex',1);
Int32=coder.newtype('int32',[1,1],'complex',0);
lattice_type=coder.newtype('int32',[inf,2],'complex',0);

%codegen -O enable:openmp -config cfg delta_full -args {ComplexMatrixType, VectorType, Int32, Int32, Int32, VectorType, lattice_type, ComplexMatrixType} -c
%codegen -O enable:openmp -config cfg delta_full -args {ComplexMatrixType, VectorType, Int32, Int32, Int32, CVectorType, lattice_type, ComplexMatrixType} 
codegen -O disable:openmp -config cfg fese_Hirschfeld_tb_5orbital_bounds_unres_mexable_as -args  {Int32, FieldType, VectorType, VectorType, CVectorType}

%function [eigeps2Daa] = fese_Hirschfeld_tb_5orbital_bounds_unres(pixelnum, kz, kx_limits, ky_limits ,t1)

% 
%     Description: 'class MexCodeConfig: MEX configuration objects with C code.'
%     Name: 'MexCodeConfig'
% 
% -------------------------------- Report -------------------------------
% 
%                       GenerateReport: false
%                         LaunchReport: false
% 
% ------------------------------- Debugging -----------------------------
% 
%                      EchoExpressions: true
%                      EnableDebugging: false
% 
% ---------------------------- Code Generation --------------------------
% 
%                       ConstantInputs: 'CheckValues'
%                  FilePartitionMethod: 'MapMFileToCFile'
%                          GenCodeOnly: false
%                   PostCodeGenCommand: ''
%                           TargetLang: 'C'
% 
% ------------------------ Language And Semantics -----------------------
% 
%               ConstantFoldingTimeout: 40000
%              DynamicMemoryAllocation: 'Threshold'
%     DynamicMemoryAllocationThreshold: 65536
%             EnableAutoExtrinsicCalls: true
%                 EnableVariableSizing: true
%                       ExtrinsicCalls: true
%                 GlobalDataSyncMethod: 'SyncAlways'
%                InitFltsAndDblsToZero: true
%            SaturateOnIntegerOverflow: true
% 
% -------------------- Safety (disable for faster MEX) ------------------
% 
%                      IntegrityChecks: true
%                 ResponsivenessChecks: true
% 
% ---------------- Function Inlining and Stack Allocation ---------------
% 
%                     InlineStackLimit: 4000
%                      InlineThreshold: 10
%                   InlineThresholdMax: 200
%                        StackUsageMax: 200000
% 
% ----------------------------- Optimizations ---------------------------
% 
%                         EnableMemcpy: true
%                         EnableOpenMP: true
%                      MemcpyThreshold: 64
% 
% ------------------------------- Comments ------------------------------
% 
%                     GenerateComments: true
%                 MATLABSourceComments: false
% 
% ------------------------------ Custom Code ----------------------------
% 
%                     CustomHeaderCode: ''
%                        CustomInclude: ''
%                    CustomInitializer: ''
%                        CustomLibrary: ''
%                         CustomSource: ''
%                     CustomSourceCode: ''
%                     CustomTerminator: ''
%                   ReservedNameArray: ''
