clear; clc; close all;

xlRange = 'C1:I1';
HardingScedAriv1 = grabData(xlRange);
xlRange = 'C5:I5';
HardingDiff1 = grabData(xlRange);
HardingWindow1 = getWaitTime(HardingDiff1);
HardingMinMaxMean1 = getMinMaxMean(HardingDiff1);

xlRange = 'C13:H13';
HardingScedAriv2 = grabData(xlRange);
xlRange = 'C17:H17';
HardingDiff2 = grabData(xlRange);
HardingWindow2 = getWaitTime(HardingDiff2);
HardingMinMaxMean2 = getMinMaxMean(HardingDiff2);

xlRange = 'C25:T25';
HardingScedAriv3 = grabData(xlRange);
xlRange = 'C29:T29';
HardingDiff3 = grabData(xlRange);
HardingWindow3 = getWaitTime(HardingDiff3);
HardingMinMaxMean3 = getMinMaxMean(HardingDiff3);

xlRange = 'C7:M7';
ProgressScedAriv1 = grabData(xlRange);
xlRange = 'C11:M11';
ProgressDiff1 = grabData(xlRange);
ProgressWindow1 = getWaitTime(ProgressDiff1);
ProgressMinMaxMean1 = getMinMaxMean(ProgressDiff1);

xlRange = 'C19:G19';
ProgressScedAriv2 = grabData(xlRange);
xlRange = 'C23:G23';
ProgressDiff2 = grabData(xlRange);
ProgressWindow2 = getWaitTime(ProgressDiff2);
ProgressMinMaxMean2 = getMinMaxMean(ProgressDiff2);

xlRange = 'C31:K31';
ProgressScedAriv3 = grabData(xlRange);
xlRange = 'C35:K35';
ProgressDiff3 = grabData(xlRange);
ProgressWindow3 = getWaitTime(ProgressDiff3);
ProgressMinMaxMean3 = getMinMaxMean(ProgressDiff3);

HardingAriv = cat(2, HardingScedAriv1, HardingScedAriv2, HardingScedAriv3);
HardingWindow = cat(2, HardingWindow1, HardingWindow2, HardingWindow3);
HardingLin = polyfit(HardingAriv, HardingWindow, 1);
m1 = HardingLin(1);
k1 = HardingLin(2);
HardingEq = k1 + m1*HardingAriv;
disp("The slope of Harding is: ");
disp(m1);
disp("The y-int of Harding is: ");
disp(k1);


ProgressAriv = cat(2, ProgressScedAriv1, ProgressScedAriv2, ProgressScedAriv3);
ProgressWindow = cat(2, ProgressWindow1, ProgressWindow2, ProgressWindow3);
ProgressLin = polyfit(ProgressAriv, ProgressWindow, 1);
m2 = ProgressLin(1);
k2 = ProgressLin(2);
ProgressEq = k2 + m2*ProgressAriv;
disp("The slope of Progress is: ");
disp(m2);
disp("The y-int of Progress is: ");
disp(k2);

% Harding
% subplot(4,1,1)
% scatter(HardingScedAriv1, HardingDiff1, '*');
% hold on;
% scatter(HardingScedAriv2, HardingDiff2, '*');
% hold on;
% scatter(HardingScedAriv3, HardingDiff3, '*');
% hold off;
% datetick('x','HH:MM')
% xlabel('Arrival Time (EST)');
% ylabel('Seconds Late (s)');
% title('Arrival Time (EST) vs Amount of Seconds (s) Harding Bus is Late')
% grid on;
% refline(0,0);

% Harding Time Window
%subplot(4,1,2)
subplot(2,1,1)
scatter(HardingAriv, HardingWindow, '*');
hold on;
plot(HardingAriv, HardingEq);
hold off;
%scatter(HardingScedAriv1, HardingWindow1, '*');
%hold on;
%scatter(HardingScedAriv2, HardingWindow2, '*');
%hold on;
%scatter(HardingScedAriv3, HardingWindow3, '*');
datetick('x','HH:MM')
xlabel('Arrival Time (EST)');
ylabel('Time Window (s)');
title('Arrival Time (EST) vs Time until Departure (s) for Harding Bus')
grid on;

% Progress
% subplot(4,1,3)
% scatter(ProgressScedAriv1, ProgressDiff1, '*');
% hold on;
% scatter(ProgressScedAriv2, ProgressDiff2, '*');
% hold on;
% scatter(ProgressScedAriv3, ProgressDiff3, '*');
% hold off;
% datetick('x','HH:MM')
% xlabel('Arrival Time (EST)');
% ylabel('Seconds Late (s)');
% title('Arrival Time (EST) vs Amount of Seconds (s) Progress Bus is Late')
% refline(0,0);
% grid on;

% Harding Time Window
%subplot(4,1,4)
subplot(2,1,2)
scatter(ProgressAriv, ProgressWindow, '*');
hold on;
plot(ProgressAriv, ProgressEq);
hold off;
% scatter(ProgressScedAriv1, ProgressWindow1, '*');
% hold on;
% scatter(ProgressScedAriv2, ProgressWindow2, '*');
% hold on;
% scatter(ProgressScedAriv3, ProgressWindow3, '*');
% hold on;
datetick('x','HH:MM')
xlabel('Arrival Time (EST)');
ylabel('Time Window (s)');
title('Arrival Time (EST) vs Time until Departure (s) for Progress Bus')
grid on;

function [Data] = grabData(xlRange)
    Filename = 'busData.xlsx';
    Sheet = 1;
    Data = xlsread(Filename,Sheet,xlRange);
end

function [MinMaxMean] = getMinMaxMean(Array)
    MinMaxMean = [min(Array), max(Array), mean(Array)];
end

function [Array] = getWaitTime(Array)
Total = numel(Array);
Count = 1;
    while Count <= Total
    Array(Count) = (-1)*(Array(Count) - 300);
    Count = Count + 1;
    end
end