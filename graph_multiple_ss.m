
close all
cd 'C:\Users\Alicia Rossi\Documents\Projects\AFRL\Carbon Fiber\carbon-sm-aug1\';
info = dir('Analysis test2-10 tests-*.mat');
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
    plot(SSR.Strain, SSR.Stress,'color', col, 'marker', '.', 'markersize', 5);                                                        % stress-strain data
    %plot(temp,[SSR.E_ind].*temp,'color',[0.5 0.5 0.5],'LineStyle','-','linewidth',2)                            % modulus line
    %plot(temp, [SSR.E_ind].*(temp - Plastic.YS_offset),'color',[0.5 0.5 0.5],'LineStyle','--','linewidth',2);   % strain offset line
    %plot(SSR.Strain(FR.segment_start:FR.segment_end), SSR.Stress(FR.segment_start:FR.segment_end), 'g.','markersize', 10);          % modulus fit data

    i= i+1;
end
xlabel('Indentation Strain ','fontsize',13)
ylabel ('Indentation Stress [GPa]','fontsize',13)
title('Fibers in direction of Indentation')
%legend('Stress-Strain','Modulus Line', 'Modulus Fit Data', 'Location', 'SOUTHEAST');
xlim([0 0.03])
ylim([0 mstress + mstress/20])
hold off
