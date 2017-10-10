
close all
cd 'C:\Users\Alicia Rossi\Documents\Projects\PP-CNT\2017-05-24 Batch #00001';
info = dir('Analysis PP_CNT_5%_500um_elastic_5-24-*.mat');
%info2 =  dir('Analysis PP_CNT-1%_500um_elastic_5-24-*.mat');
info3 = dir('Analysis PP_CNT_neat_500um_elastic_5-24-*.mat');
figure
hold on 
i = 1;
%list = ['y.'; 'm.'; 'c.'; 'r.'; 'g.'; 'b.'; 'k.'];
list = [[1 1 0]; [1 0 1]; [0 1 1]; [1 0 0]; [0 1 0]; [0 0 1]; [0 0 0]; [1 0.4 0.6]; [0.5 0.5 0.5]];
for file = info'
    load(file.name);
    
    SSR = Stress_Strain_Analysis.StressStrainResult;
    FR = Stress_Strain_Analysis.FitResult;
    mstrain = max(real(SSR.Strain));
    mstress = max(real(SSR.Stress));
    temp = [0 mstrain];
    col = list(i,:);
    plot(SSR.Strain, SSR.Stress,'color', list(1,:), 'marker', '.', 'markersize', 5);                                                        % stress-strain data
    %plot(temp,[SSR.E_ind].*temp,'color',[0.5 0.5 0.5],'LineStyle','-','linewidth',2)                            % modulus line
    %plot(temp, [SSR.E_ind].*(temp - Plastic.YS_offset),'color',[0.5 0.5 0.5],'LineStyle','--','linewidth',2);   % strain offset line
    %plot(SSR.Strain(FR.segment_start:FR.segment_end), SSR.Stress(FR.segment_start:FR.segment_end), 'g.','markersize', 10);          % modulus fit data
    i= i+1;
end

% for file = info2'
%     load(file.name);
%     SSR = Stress_Strain_Analysis.StressStrainResult;
%     FR = Stress_Strain_Analysis.FitResult;
%     mstrain = max(real(SSR.Strain));
%     mstress = max(real(SSR.Stress));
%     temp = [0 mstrain];
%     plot(SSR.Strain, SSR.Stress,'color', list(2,:), 'marker', '.', 'markersize', 5);                                                        % stress-strain data
%     %plot(temp,[SSR.E_ind].*temp,'color',[0.5 0.5 0.5],'LineStyle','-','linewidth',2)                            % modulus line
%     %plot(temp, [SSR.E_ind].*(temp - Plastic.YS_offset),'color',[0.5 0.5 0.5],'LineStyle','--','linewidth',2);   % strain offset line
%     %plot(SSR.Strain(FR.segment_start:FR.segment_end), SSR.Stress(FR.segment_start:FR.segment_end), 'g.','markersize', 10);          % modulus fit data
%     hold on
%     i= i+1;
% end
for file = info3'
    load(file.name);
    
    SSR = Stress_Strain_Analysis.StressStrainResult;
    FR = Stress_Strain_Analysis.FitResult;
    mstrain = max(real(SSR.Strain));
    mstress = max(real(SSR.Stress));
    temp = [0 mstrain];
    col = list(i,:);
    plot(SSR.Strain, SSR.Stress,'color', list(3,:), 'marker', '.', 'markersize', 5);                                                        % stress-strain data
    %plot(temp,[SSR.E_ind].*temp,'color',[0.5 0.5 0.5],'LineStyle','-','linewidth',2)                            % modulus line
    %plot(temp, [SSR.E_ind].*(temp - Plastic.YS_offset),'color',[0.5 0.5 0.5],'LineStyle','--','linewidth',2);   % strain offset line
    %plot(SSR.Strain(FR.segment_start:FR.segment_end), SSR.Stress(FR.segment_start:FR.segment_end), 'g.','markersize', 10);          % modulus fit data
    i= i+1;
end



xlabel('Indentation Strain ','fontsize',13)
ylabel ('Indentation Stress [GPa]','fontsize',13)

% Max Stress and Strain
mstress = .5;
mstrain = 0.09;
xlim([0 mstrain + mstrain/20])
ylim([0 mstress + mstress/20])
hold off
