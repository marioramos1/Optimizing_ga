function [col]=collector_data(x)
% The only input for this function is a number 1 through 9. 
% x is the identification number of the collector that you would like to
% use in the model. The variables listed will be used in the ssccall
% function, and the following shows the ID and corresponding collector.
% 
% 1	FLABEG Ultimate Trough RP6 (with 89-mm OD receiver for oil HTF)
% 2	FLABEG Ultimate Trough RP6 (with 70-mm OD receiver for molten-salt HTF)
% 3	EuroTrough ET150
% 4	Luz LS-2
% 5	Luz LS-3
% 6	Solargenix SGX-1
% 7	AlbiasaTrough AT150
% 8	SkyFuel SkyTrough (with 80-mm OD receiver)
% 9	Siemens SunField 6


load collectordata.mat;

if x==1
    col=collectordata(1,:);
    col.A_aperture=[col.A_aperture];
    col.W_aperture=[col.W_aperture];
    col.L_SCA=[col.L_SCA]; 
    col.Ave_Focal_Length=[col.Ave_Focal_Length]; 
    col.Distance_SCA=[col.Distance_SCA]; 
    col.IAM_matrix=[col.IAM_F0 col.IAM_F1 col.IAM_F2]; 
    col.TrackingError=[col.TrackingError]; 
    col.GeomEffects=[col.GeomEffects]; 
    col.Rho_mirror_clean=[col.Rho_mirror_clean]; 
    col.Dirt_mirror=[col.Dirt_mirror]; 
    col.Error=[col.Error];
    col.L_aperture=[col.L_aperture]; 
    col.ColperSCA=[10]; 
elseif x==2
    col=collectordata(2,:);
    col.A_aperture=[col.A_aperture];
    col.W_aperture=[col.W_aperture];
    col.L_SCA=[col.L_SCA]; 
    col.Ave_Focal_Length=[col.Ave_Focal_Length]; 
    col.Distance_SCA=[col.Distance_SCA]; 
    col.IAM_matrix=[col.IAM_F0 col.IAM_F1 col.IAM_F2]; 
    col.TrackingError=[col.TrackingError]; 
    col.GeomEffects=[col.GeomEffects]; 
    col.Rho_mirror_clean=[col.Rho_mirror_clean]; 
    col.Dirt_mirror=[col.Dirt_mirror]; 
    col.Error=[col.Error];
    col.L_aperture=[col.L_aperture]; 
    col.ColperSCA=[10]; 
elseif x==3
    col=collectordata(3,:);
    col.A_aperture=[col.A_aperture];
    col.W_aperture=[col.W_aperture];
    col.L_SCA=[col.L_SCA]; 
    col.Ave_Focal_Length=[col.Ave_Focal_Length]; 
    col.Distance_SCA=[col.Distance_SCA]; 
    col.IAM_matrix=[col.IAM_F0 col.IAM_F1 col.IAM_F2]; 
    col.TrackingError=[col.TrackingError]; 
    col.GeomEffects=[col.GeomEffects]; 
    col.Rho_mirror_clean=[col.Rho_mirror_clean]; 
    col.Dirt_mirror=[col.Dirt_mirror]; 
    col.Error=[col.Error];
    col.L_aperture=[col.L_aperture]; 
    col.ColperSCA=[12]; 
elseif x==4
    col=collectordata(4,:);
    col.A_aperture=[col.A_aperture];
    col.W_aperture=[col.W_aperture];
    col.L_SCA=[col.L_SCA]; 
    col.Ave_Focal_Length=[col.Ave_Focal_Length]; 
    col.Distance_SCA=[col.Distance_SCA]; 
    col.IAM_matrix=[col.IAM_F0 col.IAM_F1 col.IAM_F2]; 
    col.TrackingError=[col.TrackingError]; 
    col.GeomEffects=[col.GeomEffects]; 
    col.Rho_mirror_clean=[col.Rho_mirror_clean]; 
    col.Dirt_mirror=[col.Dirt_mirror]; 
    col.Error=[col.Error];
    col.L_aperture=[col.L_aperture]; 
    col.ColperSCA=[6]; 
elseif x==5
    col=collectordata(5,:);
    col.A_aperture=[col.A_aperture];
    col.W_aperture=[col.W_aperture];
    col.L_SCA=[col.L_SCA]; 
    col.Ave_Focal_Length=[col.Ave_Focal_Length]; 
    col.Distance_SCA=[col.Distance_SCA]; 
    col.IAM_matrix=[col.IAM_F0 col.IAM_F1 col.IAM_F2]; 
    col.TrackingError=[col.TrackingError]; 
    col.GeomEffects=[col.GeomEffects]; 
    col.Rho_mirror_clean=[col.Rho_mirror_clean]; 
    col.Dirt_mirror=[col.Dirt_mirror]; 
    col.Error=[col.Error];
    col.L_aperture=[col.L_aperture]; 
    col.ColperSCA=[12]; 
elseif x==6
    col=collectordata(6,:);
    col.A_aperture=[col.A_aperture];
    col.W_aperture=[col.W_aperture];
    col.L_SCA=[col.L_SCA]; 
    col.Ave_Focal_Length=[col.Ave_Focal_Length]; 
    col.Distance_SCA=[col.Distance_SCA]; 
    col.IAM_matrix=[col.IAM_F0 col.IAM_F1 col.IAM_F2]; 
    col.TrackingError=[col.TrackingError]; 
    col.GeomEffects=[col.GeomEffects]; 
    col.Rho_mirror_clean=[col.Rho_mirror_clean]; 
    col.Dirt_mirror=[col.Dirt_mirror]; 
    col.Error=[col.Error];
    col.L_aperture=[col.L_aperture]; 
    col.ColperSCA=[12]; 
elseif x==7
    col=collectordata(7,:);
    col.A_aperture=[col.A_aperture];
    col.W_aperture=[col.W_aperture];
    col.L_SCA=[col.L_SCA]; 
    col.Ave_Focal_Length=[col.Ave_Focal_Length]; 
    col.Distance_SCA=[col.Distance_SCA]; 
    col.IAM_matrix=[col.IAM_F0 col.IAM_F1 col.IAM_F2]; 
    col.TrackingError=[col.TrackingError]; 
    col.GeomEffects=[col.GeomEffects]; 
    col.Rho_mirror_clean=[col.Rho_mirror_clean]; 
    col.Dirt_mirror=[col.Dirt_mirror]; 
    col.Error=[col.Error];
    col.L_aperture=[col.L_aperture]; 
    col.ColperSCA=[12]; 
elseif x==8
    col=collectordata(8,:);
    col.A_aperture=[col.A_aperture];
    col.W_aperture=[col.W_aperture];
    col.L_SCA=[col.L_SCA]; 
    col.Ave_Focal_Length=[col.Ave_Focal_Length]; 
    col.Distance_SCA=[col.Distance_SCA]; 
    col.IAM_matrix=[col.IAM_F0 col.IAM_F1 col.IAM_F2]; 
    col.TrackingError=[col.TrackingError]; 
    col.GeomEffects=[col.GeomEffects]; 
    col.Rho_mirror_clean=[col.Rho_mirror_clean]; 
    col.Dirt_mirror=[col.Dirt_mirror]; 
    col.Error=[col.Error];
    col.L_aperture=[col.L_aperture]; 
    col.ColperSCA=[8]; 
elseif x==9
    col=collectordata(9,:);
    col.A_aperture=[col.A_aperture];
    col.W_aperture=[col.W_aperture];
    col.L_SCA=[col.L_SCA]; 
    col.Ave_Focal_Length=[col.Ave_Focal_Length]; 
    col.Distance_SCA=[col.Distance_SCA]; 
    col.IAM_matrix=[col.IAM_F0 col.IAM_F1 col.IAM_F2]; 
    col.TrackingError=[col.TrackingError]; 
    col.GeomEffects=[col.GeomEffects]; 
    col.Rho_mirror_clean=[col.Rho_mirror_clean]; 
    col.Dirt_mirror=[col.Dirt_mirror]; 
    col.Error=[col.Error];
    col.L_aperture=[col.L_aperture]; 
    col.ColperSCA=[8]; 
end
end
