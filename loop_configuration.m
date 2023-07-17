function trough_loop_control=loop_configuration(nSCA)
% This function used the number of user-defined solar collector assemblies
% in a single loop to configure the loop of solar collectors; this is
% necessary for MATLAB SAM wrapper to run when the user has changed the
% variable nSCA. 

trough_loop_control=zeros(3*(nSCA-1),1); 
for k=1:nSCA-1
    array_to_add=[nSCA-k+1;1 ;1];
    trough_loop_control(3*k-2:3*k)=array_to_add; 
end
trough_loop_control=[nSCA;1;1;trough_loop_control;1]; 