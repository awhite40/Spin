
close all
cd 'C:\Users\awhite40\Documents\research\Carbon Fiber\2017-10-20 Batch #00001';
info = dir('Analysis AFRL_CF_B_500um_highangle*.mat');
info2 =  dir('Analysis AFRL_CF_B_500um_mediumangle*.mat');
info3 = dir('Analysis AFRL_CF_B_500um_lowangle*.mat');
figure
hold on 
i = 1;
j=1;
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
    h1=plot(SSR.Strain, SSR.Stress,'color', list(1,:), 'marker', '.', 'markersize', 5);                                                        % stress-strain data
    %plot(temp,[SSR.E_ind].*temp,'color',[0.5 0.5 0.5],'LineStyle','-','linewidth',2)                            % modulus line
    %plot(temp, [SSR.E_ind].*(temp - Plastic.YS_offset),'color',[0.5 0.5 0.5],'LineStyle','--','linewidth',2);   % strain offset line
    %plot(SSR.Strain(FR.segment_start:FR.segment_end), SSR.Stress(FR.segment_start:FR.segment_end), 'g.','markersize', 10);          % modulus fit data
    E_list1(j) = FR.E_sample;
    testname1(j) = str2num(tnum);
    p_list1(j) = FR.P_star;
    if i==9
        i = 0;
    end
    i= i+1;
    j=j+1;
end
j = 1;
for file = info2'
    load(file.name);
    
    SSR = Stress_Strain_Analysis.StressStrainResult;
    FR = Stress_Strain_Analysis.FitResult;
    mstrain = max(real(SSR.Strain));
    mstress = max(real(SSR.Stress));
    temp = [0 mstrain];
    col = list(i,:);
    h2=plot(SSR.Strain, SSR.Stress,'color', list(2,:), 'marker', '.', 'markersize', 5);                                                        % stress-strain data
    %plot(temp,[SSR.E_ind].*temp,'color',[0.5 0.5 0.5],'LineStyle','-','linewidth',2)                            % modulus line
    %plot(temp, [SSR.E_ind].*(temp - Plastic.YS_offset),'color',[0.5 0.5 0.5],'LineStyle','--','linewidth',2);   % strain offset line
    %plot(SSR.Strain(FR.segment_start:FR.segment_end), SSR.Stress(FR.segment_start:FR.segment_end), 'g.','markersize', 10);          % modulus fit data
    E_list2(j) = FR.E_sample;
    testname2(j) = str2num(tnum);
    p_list2(j) = FR.P_star;
    if i==9
        i = 0;
    end
    i= i+1;
    j=j+1;
end
j=1;

for file = info3'
    load(file.name);
    
    SSR = Stress_Strain_Analysis.StressStrainResult;
    FR = Stress_Strain_Analysis.FitResult;
    mstrain = max(real(SSR.Strain));
    mstress = max(real(SSR.Stress));
    temp = [0 mstrain];
    col = list(i,:);
    h3=plot(SSR.Strain, SSR.Stress,'color', list(3,:), 'marker', '.', 'markersize', 5);                                                        % stress-strain data
    %plot(temp,[SSR.E_ind].*temp,'color',[0.5 0.5 0.5],'LineStyle','-','linewidth',2)                            % modulus line
    %plot(temp, [SSR.E_ind].*(temp - Plastic.YS_offset),'color',[0.5 0.5 0.5],'LineStyle','--','linewidth',2);   % strain offset line
    %plot(SSR.Strain(FR.segment_start:FR.segment_end), SSR.Stress(FR.segment_start:FR.segment_end), 'g.','markersize', 10);          % modulus fit data
    E_list3(j) = FR.E_sample;
    testname3(j) = str2num(tnum); 
    p_list3(j) = FR.P_star;
    if i==9
        i = 0;
    end
    i= i+1;
    j=j+1;
end



xlabel('Indentation Strain ','fontsize',13)
ylabel ('Indentation Stress [GPa]','fontsize',13)

% Max Stress and Strain
mstress = 1.1;
mstrain = 0.03;
xlim([0 mstrain + mstrain/20])
ylim([0 mstress + mstress/20])
legend([h1, h2,h3], '60 Degree Fibers', '30 Degree Fibers', '0 Degree Fibers')
hold off

figure
plot(p_list1,testname1,'*')
title('Single Row (60) by P*')

figure
plot(p_list2,testname2,'*')
title('Single Row (30) by P*')
figure
plot(p_list3,testname3,'*')
title('Single Row (0) by P*')
