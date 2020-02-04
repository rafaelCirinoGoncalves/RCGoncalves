function [limits] = findThreshold(carFile,intervalSize)
%this function will gather the variance on vehicle's time headway in a
%timescale. print a histogram, and find the deviation points, for what can
%be defined as a unstable acceleration

%% declaration of variables
limits = 0; %this function will gather the upper and lower bounds of this sample
intervalTicks = floor (size(carFile(:,1),1)/intervalSize);
headwaySamples = zeros(intervalTicks,1); %this will store the total sample of headway variances
percentiles = zeros (100,2);
%%
for i=1:1:intervalTicks
    if (1+(intervalSize*i)>size(carFile(:,1),1))
        headwaySamples (i,1) = nanvar(carFile(1+(intervalSize*(i-1)):end, 11));
    else
        headwaySamples (i,1) = nanvar(carFile(1+(intervalSize*(i-1)):1+(intervalSize*i), 11));
    end
end
avgVariance = nanmean (headwaySamples(:,1));
avgSD = nanstd (headwaySamples);
%hist = histogram (headwaySamples);
for i=1:1:100
  percentiles(i,1)=i;
  percentiles(i,2)=prctile(headwaySamples(:,1),i);
end
limits = avgVariance; %+(avgSD/2);%my limit is the mean + one SD, as it is a log dist always