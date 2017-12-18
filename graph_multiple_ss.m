
close all
clearvars -except E_list*
clc
cd 'C:\Users\awhite40\Documents\research\Carbon Fiber\2017-10-20 Batch #00001\';
info = dir('Analysis AFRL_CF_B_500um_lowangle*.mat');

figure
hold on 
i = 1;
%list = ['y.'; 'm.'; 'c.'; 'r.'; 'g.'; 'b.'; 'k.'];
list = [[1 1 0]; [1 0 1]; [0 1 1]; [1 0 0]; [0 1 0]; [0 0 1]; [0 0 0]; [1 0.4 0.6]; [0.5 0.5 0.5]];
j=1;
% for file = info'
%     load(file.name);
%     
%     SSR = Stress_Strain_Analysis.StressStrainResult;
%     FR = Stress_Strain_Analysis.FitResult;
%     mstrain = max(real(SSR.Strain));
%     mstress = max(real(SSR.Stress));
%     temp = [0 mstrain];
%     col = list(i,:);
%     plot(SSR.Strain, SSR.Stress,'color', col, 'marker', '.', 'markersize', 5);                                                        % stress-strain data
%     %plot(temp,[SSR.E_ind].*temp,'color',[0.5 0.5 0.5],'LineStyle','-','linewidth',2)                            % modulus line
%     %plot(temp, [SSR.E_ind].*(temp - Plastic.YS_offset),'color',[0.5 0.5 0.5],'LineStyle','--','linewidth',2);   % strain offset line
%     %plot(SSR.Strain(FR.segment_start:FR.segment_end), SSR.Stress(FR.segment_start:FR.segment_end), 'g.','markersize', 10);          % modulus fit data
%     
%     E_list1(j) = FR.E_sample;
%     testname1(j) = str2num(tnum);
%     p_list1(j) = FR.P_star;
%     j = j+1;
%     if i==9
%         i=0;
%     end
%     i= i+1;
% end
% xlabel('Indentation Strain ','fontsize',13)
% ylabel ('Indentation Stress [GPa]','fontsize',13)
% title('Fibers at approximatly 0 degrees')
% %legend('Stress-Strain','Modulus Line', 'Modulus Fit Data', 'Location', 'SOUTHEAST');
% xlim([0 0.03])
% ylim([0 mstress + mstress/20])
% hold off
% figure
% hold on
i=1;
j=1;
for file = info'
    load(file.name);
    SSR = Stress_Strain_Analysis.StressStrainResult;
    FR = Stress_Strain_Analysis.FitResult;
    data = TestData.Data;
    FR = Stress_Strain_Analysis.FitResult;
    mstrain = max(real(SSR.Strain));
    mstress = max(real(SSR.Stress));
    temp = [0 mstrain];
    col = list(i,:);
    plot(data(:,3), data(:,4),'color', col, 'marker', '.', 'markersize', 5);                                                        % stress-strain data
    %plot(temp,[SSR.E_ind].*temp,'color',[0.5 0.5 0.5],'LineStyle','-','linewidth',2)                            % modulus line
    %plot(temp, [SSR.E_ind].*(temp - Plastic.YS_offset),'color',[0.5 0.5 0.5],'LineStyle','--','linewidth',2);   % strain offset line
    %plot(SSR.Strain(FR.segment_start:FR.segment_end), SSR.Stress(FR.segment_start:FR.segment_end), 'g.','markersize', 10);          % modulus fit data
    E_list0(j) = Estat;
    testname1(j) = str2num(tnum);
    p_list1(j) = FR.P_star;
    if i==9
        i=0;
    end
    i= i+1;
    j=j+1;
end
xlabel('Load','fontsize',13)
ylabel ('Stiffness','fontsize',13)
title('Fibers at high angle Stiffness Load')
%legend('Stress-Strain','Modulus Line', 'Modulus Fit Data', 'Location', 'SOUTHEAST');
%xlim([0 0.03])
%ylim([0 mstress + mstress/20])
hold off
