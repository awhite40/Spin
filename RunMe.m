% This script is used to change variables and run the main functions for the analysis 
% Please see ReadMe.txt before begining
% Errors often occur when...
    % 1)trying to load data that doesn't exist or is in the wrong format
    % 2)there are no answers left over after filtering
tic    
%% Step 1. Load data and perform zero-point and modulus regression analyses for a large array of segments
clc
clear
close all
%folder = 'C:\Users\Alicia Rossi\Documents\Projects\AFRL\Carbon Fiber\2017-05-08 Batch #00001\';      % e.g., 'C:\folder\subfolder\', requires \ at the end
%file = 'AFRL_CF_A_5-8-2017.xls'; % use appropriate .xls or .xlsx
%folder = 'C:\Users\Alicia Rossi\Google Drive\Test Batches\GlassFiber\2017-07-19 Batch #00001\' ;%Raw Indentation data\2017-05-24 Batch #00001\';
folder = 'C:\Users\awhite40\Google Drive\Project __ compmicro\Raw Indentation data\2017-05-05 Batch #00001\';
file = 'PP-CNT-5%-clamp.xls';
%file = 'GFE2-0_500um_TestO1.xls';
%folder = 'C:\Users\Alicia Rossi\Google Drive\Test Batches\CarbonFiber\2017-06-27 Batch #00001\';
%file = 'CF_1500um_6-27-2017.xls';
%folder = 'C:\Users\Alicia Rossi\Documents\Projects\AFRL\Carbon Fiber\carbon-sm-aug1\';
%folder = uigetdir('pick directory containing frames and detections');
%folder = [folder '/'];
%file = 'CF_A_60_500um_cycle.xls';


% excel file should have segment type, time, displacement, load, harmonics
                            % stiffness, harmonic displacement, and harmonic load in that order
tnum = '04';                 % used for saving and reading the test number
sheet = ['Test 0', tnum];  % name of sheet in file, add or remove a zero depending on tnum

seg_sizes = [10:20:500]; % an array of segment sizes for which to analyze, use a minimum number for speed

%SearchSegEnd = 1280;                % cut off no. of data points, analyzes data up to this value 
                                    % SearchSegEnd must be <= EndLoadSegment Marker in raw data or an error will occur

Rind =500 * 1e3;        % indenter radius in nm, ie. 100000 (100um), 16500 (16.5um)
vs = 0.3;           % sample Poisson ratio, only matters if you want to compute the sample modulus
skip = [0.3 0.1];   % aborts and skips over any analysis with Fit1 R2 < skip(1) AND length(Fit2)/length(Fit1) < skip(2)
                    % modulus also has to be real value
CSM = 0;            % choose whether to apply CSM corrections (CSM = 1) or not (CSM = 0) or just Pact and hact (CSM = 2)
SS_fit = 1;
% these are based on Vachhani et al. (2013) Acta Materialia http://dx.doi.org/10.1016/j.actamat.2013.03.005


% limx = 80; %% set to 0 as default
% limzerox = 0; %% set to 0 as default (250000 is typical for 100um on Ti)
% seg_start = 350;
% seg_end = 450;


% Zero-point and modulus regression analysis of a single test
[TestData, FitResults, SearchSegEnd] = Driver([folder, file], sheet, Rind, vs, seg_sizes, skip, CSM,SS_fit);
    % Fit Results contains all the regression analyses
    % TestData contains the raw and CSM corrected data
start = find(TestData.Data(:,3)>.5,1,'first')

% You will only see this graph if you run the code section by section
hold on
plot(TestData.Data(1:200,2), TestData.Data(1:200,3));
plot(TestData.Data(start,2), TestData.Data(start,3),'r.', 'markersize', 10);
ylabel('Load (mN)','fontsize',13)
xlabel ('Displacement (nm)','fontsize',13)
hold off


%plotint(TestData, seg_start, seg_end, limx, limzerox);
%% Step 2. Filter down FitResults based on different criteron

% see filterResults.m for a full list of Filt 'variables' and [value formats]
% anything you want can be added as long as it is saved in FitResults
Filt ={...
    %'Modulus', [300 340];...
    %'R21', [0.5 1.0];...
    'R22', [0.7 1.0] ;...
    %'R23', [0.8 1.0];...
    'P*', [-5 5];... 
%     'h*', 15;...
    %'dP', [-2,2];... 
    %'dH', [-2 2];... 
    %'h_change', [-0.7 0.7];...
    'SegStart', [500, 1100]
    %'SegEnd', [100,1200]
    'ModLength', [50, 900]; ...
    %'Hr', [-30, 30]; ..
    };

bins = 20; % number of bins for the historgram plots

% Plastic contains all the parameters for determing yield strength (Yind) and
% hardening fits. These are not standardized. See FindYieldStart.m and
% FindYield_v2.m for details of variables and calculations.

Plastic.method = 'linear';          % method for finding Yind, see FindYield_v2.m for details and options
Plastic.YS_offset = 0.002;          % offset strain for Yind
Plastic.H_offset = [0.003 0.02];    % offset strains for first hardneing fit
Plastic.H_offset2 = 0.25;           % max offset strain for 2nd hardening fit (start of fit is the end of the first hardening fit)
Plastic.YS_window = [0 4];          % +/- faction of YS_offset in which to calc median stress and strain
Plastic.pop_in = .001;               % threshold strain burst to consider a pop-in, use Inf to ignore this
                                    % if a pop-in is recorded, Yind is then determined from a back-extrapolation,
Plastic.pop_window = 3;             % number of data points for calculating strain burst (i.e. n+3 - n)
Plastic.C_dstrain = 0;              % tuning variable for the start of the back-extrapolation after a pop-in
Plastic.smooth_window = 0;          % +/- number of points for movering average on strain, used for hardening fits, use 0 to ignore

BEuler=[0 0 0]';                    % bunge-euler angles, shows up on plots, useful when doing single grain indents

Plastic.Eassume = 0;                % forced Young's modulus for determing the contact radius, use 0 to ignore
                                    % this will alter the indentation stress-strain curve, only recomended for troubleshooting

% Filters through FitResults and plots histograms of SearchResults and 3-D interactive plot for selecting an answer
[SearchResults, npoints, HistSearchResults] = SearchExplorer(TestData, FitResults, Filt, Plastic, BEuler, bins, SearchSegEnd, SS_fit);
toc
% 3-D interactive plot instructions
    % click on any point in Figure (1), then click on the "Plot ISS Analysis" button to see the answer
    % recording this answer, click on "Save FR & ISS"
    % recording all the answer, click on "Save All ISS" 
%% Step 2.2 after you have NewFilt

[SearchResults, npoints, HistSearchResults] = SearchExplorer(TestData, FitResults, NewFilt, Plastic, BEuler, bins, SearchSegEnd, SS_fit);


%% Step 3. Save your work as .mat and .png
% you must 
    % (1) Calculate the stress-strain curves for all the SearchResults you see as acceptable answers. Click on the "Save All ISS" button in Figure 1
    % (2) Select, calculate, and plot a single representative answer. Click on "Save FR & ISS" button to save the currently selected data point. 
    %     Keep the plot for this answer up, Click on "Plot ISS Analysis"
    %     and close all the other figures.

% computes the statistics of the indentation properties for the SearchResults
[Estat, Ystat, Hstat, Hstat2] = MyHistResults(SearchResults, Stress_Strain_Search_Results)

% save workspace and the ISS plot in the same folder as the raw data
% caution!!! this will overwrite data if files with the same name already exists
save([folder,'Analysis ', file(1:end-4), '-', tnum])           % saves your entire workspace
set(gcf,'PaperPositionMode','auto')       % makes the plots full screen
saveas(gcf,[folder, 'ISS ', file(1:end-4), '-', tnum], 'png')  % grabs the current plot, close others you don't want
