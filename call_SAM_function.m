function opt_percent_des=call_SAM_function(x)
try
% Unpack the array of simulation parameters to be optimized
specified_solar_multiple = x(1); % the solar multiple of the field
q_pb_design = x(2); %the designed thermal heat to sink 
nSCA = 6; % the number of collector assemblies per loop
tshours = x(3); % the equivalent hours of thermal energy storage at design
T_in_loop_des = 200; 
T_out_loop = 375; 

%% Assigning necessary variables and configurations
% Empty array to be used for Percent at Design Point calculations
array=zeros(8760,1); 

% Selects the data associated with the user-selected collector; see the
% help of collector_data for more information. 
col=collector_data(7); 

% Selects the data associated with the user-selected receiver; see the
% help of receiver_data for more information. 
HCE=receiver_data(5); 

% Adjusts the loop configuration to match the user nSCA input. 
trough_loop_control=loop_configuration(nSCA); 

% Selecting a location of the concentrated solar plant; % This location 
% selection code is temporary; we will find a way to implement locations 
% across the continental United States, and the location selection will be 
% its own MATLAB function. But for now, we have this: 
location = 2; 
if location == 1
    y= 'S:/COE/STEP/00 SUMMER RESEARCH/2023 Summer 2023/Ramos/SAM MATLAB/2022.11.21/solar_resource/tucson_az_32.116521_-110.933042_psmv3_60_tmy.csv';
    disp("Tucson, Arizona");
elseif location == 2
    y= 'S:/COE/STEP/00 SUMMER RESEARCH/2023 Summer 2023/Ramos/SAM MATLAB/2022.11.21/solar_resource/daggett_ca_34.865371_-116.783023_psmv3_60_tmy.csv';
elseif location == 3
    y= 'S:/COE/STEP/00 SUMMER RESEARCH/2023 Summer 2023/Ramos/SAM MATLAB/2022.11.21/solar_resource/fargo_nd_46.9_-96.8_mts1_60_tmy.csv';
    disp("Fargo, North Dakota");
elseif location == 4
    y= 'S:/COE/STEP/00 SUMMER RESEARCH/2023 Summer 2023/Ramos/SAM MATLAB/2022.11.21/solar_resource/valparaiso_in_915193_41.49_-87.06_tmy-2021.csv'; 
    disp("Valparaiso, Indiana"); 
end

non_solar_land_area_multiplier=1.10; % the land area multiplier

%% Assigning variables in ssccall data
    % For more information about each variable, see the SDKtool. 
ssccall('load');
ssccall('module_exec_set_print',0);
data = ssccall('data_create');
ssccall('data_set_string', data, 'file_name', y);
ssccall('data_set_number', data, 'track_mode', 1);
ssccall('data_set_number', data, 'tilt', 0);
ssccall('data_set_number', data, 'azimuth', 0);
ssccall('data_set_number', data, 'I_bn_des', 950);
ssccall('data_set_number', data, 'T_loop_in_des', T_in_loop_des);
ssccall('data_set_number', data, 'T_loop_out', T_out_loop);
ssccall('data_set_number', data, 'q_pb_design', q_pb_design);
ssccall('data_set_number', data, 'tshours', tshours);
ssccall('data_set_number', data, 'nSCA', nSCA);
ssccall('data_set_number', data, 'nHCEt', 4);
ssccall('data_set_number', data, 'nColt', 1);
ssccall('data_set_number', data, 'nHCEVar', 4);
ssccall('data_set_number', data, 'eta_pump', 0.84999999999999998);
ssccall('data_set_number', data, 'HDR_rough', 4.57e-05);
ssccall('data_set_number', data, 'theta_stow', 170);
ssccall('data_set_number', data, 'theta_dep', 10);
ssccall('data_set_number', data, 'Row_Distance', 15);
ssccall('data_set_number', data, 'FieldConfig', 1);
ssccall('data_set_number', data, 'is_model_heat_sink_piping', 0);
ssccall('data_set_number', data, 'L_heat_sink_piping', 50);
ssccall('data_set_number', data, 'm_dot_htfmin', 1);
ssccall('data_set_number', data, 'm_dot_htfmax', 12);
ssccall('data_set_number', data, 'Fluid', 21);
ssccall('data_set_number', data, 'wind_stow_speed', 25);
field_fl_props =[ 20   4.18   999   0.001  1e-06   0.587   85.3 ; 40   4.18   993   0.000653   6.58e-07   0.618   169 ; 60   4.18   984   0.000467   4.75e-07   0.642   252 ; 80   4.19   972   0.000355   3.65e-07   0.657   336 ; 100   4.21   959   0.000282   2.94e-07   0.666   420 ; 120   4.25   944   0.000233   2.460e-07   0.67   505 ; 140   4.28   927   0.000197   2.12e-07   0.67   590 ; 160   4.34   908   0.000171  1.88e-07   0.667   676 ; 180   4.4   887   0.00015   1.69e-07   0.661   764 ; 200   4.49   865   0.000134   1.55e-07   0.651   852 ; 220   4.58   842   0.000118   1.41e-07   0.641   941 ];
ssccall( 'data_set_matrix', data, 'field_fl_props', field_fl_props );
ssccall('data_set_number', data, 'T_fp', 10);
ssccall('data_set_number', data, 'Pipe_hl_coef', 0.45);
ssccall('data_set_number', data, 'SCA_drives_elec', 125);ssccall('data_set_number', data, 'water_usage_per_wash', 0.7);
ssccall('data_set_number', data, 'washing_frequency', 12);
ssccall('data_set_number', data, 'accept_mode', 0);
ssccall('data_set_number', data, 'accept_init', 0);
ssccall('data_set_number', data, 'accept_loc', 1);
ssccall('data_set_number', data, 'mc_bal_hot', 0.20);
ssccall('data_set_number', data, 'mc_bal_cold', 0.20);
ssccall('data_set_number', data, 'mc_bal_sca', 4.5);
W_aperture =col.W_aperture;
ssccall( 'data_set_array', data, 'W_aperture', W_aperture );
A_aperture =col.A_aperture;
ssccall( 'data_set_array', data, 'A_aperture', A_aperture );
TrackingError =col.TrackingError;
ssccall( 'data_set_array', data, 'TrackingError', TrackingError );
GeomEffects =col.GeomEffects;
ssccall( 'data_set_array', data, 'GeomEffects', GeomEffects );
Rho_mirror_clean =col.Rho_mirror_clean;
ssccall( 'data_set_array', data, 'Rho_mirror_clean', Rho_mirror_clean );
Dirt_mirror =col.Dirt_mirror;
ssccall( 'data_set_array', data, 'Dirt_mirror', Dirt_mirror );
Error =col.Error;
ssccall( 'data_set_array', data, 'Error', Error );
Ave_Focal_Length =col.Ave_Focal_Length;
ssccall( 'data_set_array', data, 'Ave_Focal_Length', Ave_Focal_Length );
L_SCA =col.L_SCA;
ssccall( 'data_set_array', data, 'L_SCA', L_SCA );
L_aperture =col.L_aperture;
ssccall( 'data_set_array', data, 'L_aperture', L_aperture );
ColperSCA =col.ColperSCA;
ssccall( 'data_set_array', data, 'ColperSCA', ColperSCA );
Distance_SCA =col.Distance_SCA;
ssccall( 'data_set_array', data, 'Distance_SCA', Distance_SCA );
IAM_matrix =col.IAM_matrix;
ssccall( 'data_set_matrix', data, 'IAM_matrix', IAM_matrix );
HCE_FieldFrac = HCE.HCE_FieldFrac;
ssccall( 'data_set_matrix', data, 'HCE_FieldFrac', HCE_FieldFrac );
D_2 = HCE.D_2; 
ssccall( 'data_set_matrix', data, 'D_2', D_2 );
D_3 = HCE.D_3; 
ssccall( 'data_set_matrix', data, 'D_3', D_3 );
D_4 = HCE.D_4; 
ssccall( 'data_set_matrix', data, 'D_4', D_4 );
D_5 = HCE.D_5; 
ssccall( 'data_set_matrix', data, 'D_5', D_5 );
D_p = HCE.D_p; 
ssccall( 'data_set_matrix', data, 'D_p', D_p );
Flow_type = HCE.Flow_type; 
ssccall( 'data_set_matrix', data, 'Flow_type', Flow_type );
Rough = HCE.Rough; 
ssccall( 'data_set_matrix', data, 'Rough', Rough );
alpha_env = HCE.alpha_env; 
ssccall( 'data_set_matrix', data, 'alpha_env', alpha_env );
epsilon_3_11 = HCE.epsilon_3_11; 
ssccall( 'data_set_matrix', data, 'epsilon_3_11', epsilon_3_11 );
epsilon_3_12 = HCE.epsilon_3_12; 
ssccall( 'data_set_matrix', data, 'epsilon_3_12', epsilon_3_12 );
epsilon_3_13 = HCE.epsilon_3_13; 
ssccall( 'data_set_matrix', data, 'epsilon_3_13', epsilon_3_13 );
epsilon_3_14 = HCE.epsilon_3_14; 
ssccall( 'data_set_matrix', data, 'epsilon_3_14', epsilon_3_14 );
epsilon_3_21 = HCE.epsilon_3_21; 
ssccall( 'data_set_matrix', data, 'epsilon_3_21', epsilon_3_21 );
epsilon_3_22 = HCE.epsilon_3_22;
ssccall( 'data_set_matrix', data, 'epsilon_3_22', epsilon_3_22 );
epsilon_3_23 = HCE.epsilon_3_23;
ssccall( 'data_set_matrix', data, 'epsilon_3_23', epsilon_3_23 );
epsilon_3_24 = HCE.epsilon_3_24;
ssccall( 'data_set_matrix', data, 'epsilon_3_24', epsilon_3_24 );
epsilon_3_31 = HCE.epsilon_3_31;
ssccall( 'data_set_matrix', data, 'epsilon_3_31', epsilon_3_31 );
epsilon_3_32 = HCE.epsilon_3_32;
ssccall( 'data_set_matrix', data, 'epsilon_3_32', epsilon_3_32 );
epsilon_3_33 = HCE.epsilon_3_33;
ssccall( 'data_set_matrix', data, 'epsilon_3_33', epsilon_3_33 );
epsilon_3_34 = HCE.epsilon_3_34;
ssccall( 'data_set_matrix', data, 'epsilon_3_34', epsilon_3_34 );
epsilon_3_41 = HCE.epsilon_3_41;
ssccall( 'data_set_matrix', data, 'epsilon_3_41', epsilon_3_41 );
epsilon_3_42 = HCE.epsilon_3_42;
ssccall( 'data_set_matrix', data, 'epsilon_3_42', epsilon_3_42 );
epsilon_3_43 = HCE.epsilon_3_43;
ssccall( 'data_set_matrix', data, 'epsilon_3_43', epsilon_3_43 );
epsilon_3_44 = HCE.epsilon_3_44;
ssccall( 'data_set_matrix', data, 'epsilon_3_44', epsilon_3_44 );
alpha_abs = HCE.alpha_abs;
ssccall( 'data_set_matrix', data, 'alpha_abs', alpha_abs );
Tau_envelope = HCE.Tau_envelope; 
ssccall( 'data_set_matrix', data, 'Tau_envelope', Tau_envelope );
EPSILON_4 = HCE.EPSILON_4; 
ssccall( 'data_set_matrix', data, 'EPSILON_4', EPSILON_4 );
EPSILON_5 = HCE.EPSILON_5; 
ssccall( 'data_set_matrix', data, 'EPSILON_5', EPSILON_5 );
GlazingIntactIn = HCE.GlazingIntactIn; 
ssccall( 'data_set_matrix', data, 'GlazingIntactIn', GlazingIntactIn );
P_a = HCE.P_a; 
ssccall( 'data_set_matrix', data, 'P_a', P_a );
AnnulusGas = HCE.AnnulusGas; 
ssccall( 'data_set_matrix', data, 'AnnulusGas', AnnulusGas );
AbsorberMaterial = HCE.AbsorberMaterial; 
ssccall( 'data_set_matrix', data, 'AbsorberMaterial', AbsorberMaterial );
Shadowing = HCE.Shadowing; 
ssccall( 'data_set_matrix', data, 'Shadowing', Shadowing );
Dirt_HCE = HCE.Dirt_HCE; 
ssccall( 'data_set_matrix', data, 'Dirt_HCE', Dirt_HCE );
Design_loss = HCE.Design_loss; 
ssccall( 'data_set_matrix', data, 'Design_loss', Design_loss );
ssccall('data_set_number', data, 'pb_pump_coef', 0.55);
ssccall('data_set_number', data, 'init_hot_htf_percent', 30);
ssccall('data_set_number', data, 'h_tank', 15);
ssccall('data_set_number', data, 'cold_tank_max_heat', 0.5);
ssccall('data_set_number', data, 'u_tank', 0.3);
ssccall('data_set_number', data, 'tank_pairs', 1);
ssccall('data_set_number', data, 'cold_tank_Thtr', 60);
ssccall('data_set_number', data, 'h_tank_min', 0.5);
ssccall('data_set_number', data, 'hot_tank_Thtr', 110);
ssccall('data_set_number', data, 'hot_tank_max_heat', 1);
weekday_schedule =[1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1];
ssccall( 'data_set_matrix', data, 'weekday_schedule', weekday_schedule );
weekend_schedule =[1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1; 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1];
ssccall( 'data_set_matrix', data, 'weekend_schedule', weekend_schedule );
ssccall('data_set_number', data, 'is_tod_pc_target_also_pc_max', 0);
ssccall('data_set_number', data, 'is_dispatch', 0);
ssccall('data_set_number', data, 'disp_frequency', 24);
ssccall('data_set_number', data, 'disp_horizon', 48);
ssccall('data_set_number', data, 'disp_max_iter', 35000);
ssccall('data_set_number', data, 'disp_timeout', 5);
ssccall('data_set_number', data, 'disp_mip_gap', 0.001);
ssccall('data_set_number', data, 'disp_time_weighting', 0.99);
ssccall('data_set_number', data, 'disp_rsu_cost_rel', 952);
ssccall('data_set_number', data, 'disp_csu_cost_rel', 87);
ssccall('data_set_number', data, 'disp_pen_ramping', 1);
ssccall('data_set_number', data, 'is_wlim_series', 0);
wlim_series = readmatrix( 'S:/COE/STEP/00 SUMMER RESEARCH/2023 Summer 2023/Ramos/SAM MATLAB/wlim_series.csv');
ssccall( 'data_set_array', data, 'wlim_series', wlim_series );
f_turb_tou_periods =[ 1; 1; 1; 1; 1; 1; 1; 1; 1 ];
ssccall( 'data_set_array', data, 'f_turb_tou_periods', f_turb_tou_periods );
ssccall('data_set_number', data, 'is_dispatch_series', 0);
dispatch_series = 0 ;
ssccall( 'data_set_array', data, 'dispatch_series', dispatch_series );
ssccall('data_set_number', data, 'pb_fixed_par', 0.0055);
bop_array =[ 0; 1; 0; 0.48299999999999998; 0 ];
ssccall( 'data_set_array', data, 'bop_array', bop_array );
aux_array =[ 0.023; 1; 0.483; 0.571; 0 ];
ssccall( 'data_set_array', data, 'aux_array', aux_array );
ssccall('data_set_number', data, 'calc_design_pipe_vals', 1);
ssccall('data_set_number', data, 'V_hdr_cold_max', 3);
ssccall('data_set_number', data, 'V_hdr_cold_min', 2);
ssccall('data_set_number', data, 'V_hdr_hot_max', 3);
ssccall('data_set_number', data, 'V_hdr_hot_min', 2);
ssccall('data_set_number', data, 'N_max_hdr_diams', 10);
ssccall('data_set_number', data, 'L_rnr_pb', 25);
ssccall('data_set_number', data, 'L_rnr_per_xpan', 70);
ssccall('data_set_number', data, 'L_xpan_hdr', 20);
ssccall('data_set_number', data, 'L_xpan_rnr', 20);
ssccall('data_set_number', data, 'Min_rnr_xpans', 1);
ssccall('data_set_number', data, 'northsouth_field_sep', 20);
ssccall('data_set_number', data, 'N_hdr_per_xpan', 2);
ssccall('data_set_number', data, 'offset_xpan_hdr', 1);
K_cpnt =[ 0.9000   0   0.19   0   0.90   -1   -1   -1   -1   -1   -1 ; 0   0.60  0.050   0   0.60   0   0.60   0   0.42   0   0.15 ; 0.0503   0   0.42   0   0.60   0   0.60   0   0.42   0   0.15 ; 0.050   0   0.42   0   0.60   0   0.60   0   0.42   0   0.15 ; 0.050   0   0.42   0   0.60   0   0.60   0   0.42   0   0.15 ; 0.050   0   0.42   0   0.60   0   0.60   0   0.42  0   0.15 ; 0.05000   0   0.41999999999999998   0   0.59999999999999998   0   0.59999999999999998   0   0.41999999999999998   0   0.15 ; 0.05000   0   0.42   0   0.60   0   0.60   0   0.15   0.6   0 ; 0.9   0   0.19   0   0.9   -1   -1   -1   -1   -1   -1 ];
ssccall( 'data_set_matrix', data, 'K_cpnt', K_cpnt );
D_cpnt =[ 0.085   0.0635   0.085   0.0635   0.085  -1   -1   -1   -1   -1   -1 ; 0.085   0.085   0.085   0.0635   0.0635   0.0635   0.06350   0.06350   0.06350   0.06350   0.0850 ; 0.0850   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.0850 ; 0.0850   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.0850 ; 0.0850   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.0850 ; 0.0850   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.0850 ; 0.0850   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.0850 ; 0.0850   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.06350   0.0850   0.0850   0.0850 ; 0.0850   0.06350   0.0850   0.06350   0.0850   -1   -1   -1   -1   -1   -1 ];
ssccall( 'data_set_matrix', data, 'D_cpnt', D_cpnt );
L_cpnt =[ 0   0   0   0   0   -1   -1   -1   -1   -1   -1 ; 0   0   0   1   0   0   0   1   0   1   0 ; 0   1   0   1   0   0   0   1   0   1   0 ; 0   1   0   1   0   0   0   1   0   1   0 ; 0   1   0   1   0   0   0   1   0   1   0 ; 0   1   0   1   0   0   0   1   0   1   0 ; 0   1   0   1   0   0   0   1   0   1   0 ; 0   1   0   1   0   0   0   1   0   0   0 ; 0   0   0   0   0   -1   -1   -1   -1   -1   -1 ];
ssccall( 'data_set_matrix', data, 'L_cpnt', L_cpnt );
Type_cpnt =[ 0   1   0   1   0   -1   -1   -1   -1   -1   -1;1   0   0   2   0   1   0   2   0   2   0 ; 0   2   0   2   0   1   0   2   0   2   0 ; 0   2   0   2   0   1   0   2   0   2   0 ; 0   2   0   2   0   1   0   2   0   2   0 ; 0   2   0   2   0   1   0   2   0   2   0 ; 0   2   0   2   0   1   0   2   0   2   0 ; 0   2   0   2   0   1   0   2   0   0   1 ; 0   1   0   1   0   -1   -1   -1   -1   -1   -1 ];
ssccall( 'data_set_matrix', data, 'Type_cpnt', Type_cpnt );
ssccall('data_set_number', data, 'custom_sf_pipe_sizes', 0);
sf_rnr_diams = -1 ;
ssccall( 'data_set_matrix', data, 'sf_rnr_diams', sf_rnr_diams );
sf_rnr_wallthicks = -1 ;
ssccall( 'data_set_matrix', data, 'sf_rnr_wallthicks', sf_rnr_wallthicks );
sf_rnr_lengths = -1 ;
ssccall( 'data_set_matrix', data, 'sf_rnr_lengths', sf_rnr_lengths );
sf_hdr_diams = -1 ;
ssccall( 'data_set_matrix', data, 'sf_hdr_diams', sf_hdr_diams );
sf_hdr_wallthicks = -1 ;
ssccall( 'data_set_matrix', data, 'sf_hdr_wallthicks', sf_hdr_wallthicks );
sf_hdr_lengths = -1 ;
ssccall( 'data_set_matrix', data, 'sf_hdr_lengths', sf_hdr_lengths );
ssccall('data_set_number', data, 'tanks_in_parallel', 1);
ssccall('data_set_number', data, 'specified_solar_multiple', specified_solar_multiple); 
ssccall('data_set_number', data, 'non_solar_field_land_area_multiplier', non_solar_land_area_multiplier);
ssccall( 'data_set_array', data, 'trough_loop_control', trough_loop_control );
ssccall('data_set_number', data, 'disp_wlim_maxspec', 9.9999999999999998e+37);
ssccall('data_set_number', data, 'adjust:constant', 4);
ssccall('data_set_number', data, 'electricity_rate', 0.06);
ssccall('data_set_number', data, 'fixed_operating_cost', 400000);

%% Creating and executing trough module for PTC IPH
module = ssccall('module_create', 'trough_physical_process_heat');
ok = ssccall('module_exec', module, data);
if ~ok
    disp('trough_physical_process_heat errors:');
    ii=0;
    while 1
        err = ssccall('module_log', module, ii);
        if strcmp(err,'')
            break;
        end
        disp( err );
        ii=ii+1;
    end
    return
end

ssccall('module_free', module);
%% Creating and executing module that connects IPH to LCOH
module = ssccall('module_create', 'iph_to_lcoefcr');
ok = ssccall('module_exec', module, data);
if ~ok
    disp('iph_to_lcoefcr errors:');
    ii=0;
    while 1
        err = ssccall('module_log', module, ii);
        if strcmp(err,'')
            break;
        end
        disp( err );
        ii=ii+1;
    end
    return
end
ssccall('module_free', module);

%% Establishing some numbers for capital_cost 

fixed_land_area = ssccall('data_get_number', data, 'fixed_land_area'); % [acres]
Q_tes = q_pb_design*tshours; % TES thermal capacity
total_land_area = fixed_land_area*non_solar_land_area_multiplier*4046.86; % [m^2]

site_improvements_cost_per_square_meter = 30; 
solar_field_cost_per_square_meter = 187; 
HTF_system_cost_per_square_meter = 70; 

cost_per_square_meter=site_improvements_cost_per_square_meter+solar_field_cost_per_square_meter+HTF_system_cost_per_square_meter; 
storage_cost_per_MWh = 75000; 

capital_cost = (total_land_area*cost_per_square_meter) + (Q_tes*storage_cost_per_MWh); 
capital_cost = 1.1 * capital_cost; 
ssccall('data_set_number', data, 'capital_cost', capital_cost);
ssccall('data_set_number', data, 'variable_operating_cost', 0.001);
ssccall('data_set_number', data, 'fixed_charge_rate', 0.10636199476096372);

%% Creating and executing LCOH module
module = ssccall('module_create', 'lcoefcr');
ok = ssccall('module_exec', module, data);
if ~ok
    disp('lcoefcr errors:');
    ii=0;
    while 1
        err = ssccall('module_log', module, ii);
        if strcmp(err,'')
            break;
        end
        disp( err );
        ii=ii+1;
    end
    return
end
ssccall('module_free', module);

%% Retrieving numbers after the modules have been executed
heat_to_sink = ssccall('data_get_array', data, 'q_dot_to_heat_sink');

%% Calculating the percent that  plant operates at design heat sink output
for i=1:length(heat_to_sink)
    if heat_to_sink(i) > 19 && heat_to_sink(i)<21
        array_to_add=[heat_to_sink(i)];
        array(i,1)=array_to_add;
    else
    end

end
% array is filled with zeros because the array space was pre-allocated
    % must eliminate zeros to calculate hours at design point. 
array = nonzeros(array); 

real_capacity_factor=(length(array)/length(heat_to_sink))*100; 
opt_percent_des = 100 - real_capacity_factor; 
disp('Good Simulation'); 
disp(x);
ssccall('data_free', data);
ssccall('unload');
catch
     opt_percent_des = 2000; 
     disp('Failed Simulation'); 
     disp(x); 
end
end
