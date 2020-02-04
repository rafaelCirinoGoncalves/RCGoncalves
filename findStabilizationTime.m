function [stabilizationTime] = findStabilizationTime (carFile,intervalSize, limit)
%this function will return the time interval in which the driver stabilizes their headway time
%we defined it as a momment when driver spends (5x interval) secs or more without the variance on their headway (in a N sec interval) does not exceed the limit.

stabilizationTime = 0;
for i=1:intervalSize:(size(carFile,1)-10*intervalSize)-1
    a=1;
    flag = 1;
    while (a <= 10 && flag ==1)
        var1= nanvar(carFile(1+i+((a-1)*intervalSize):1+i+(a*intervalSize),11));
        %% debug
      %  debugVar = zeros (size(carFile,1)-1,1);
      %  debugVar(1+i+((a-1)*intervalSize):1+i+(a*intervalSize),1)=carFile(1+i+((a-1)*intervalSize):1+i+(a*intervalSize),11);;
       % plot (carFile(1:end,11))
        %hold on
       % plot (debugVar);
      %  hold off
        
        %%
        if var1 <= limit
            flag=1;
        else
            
            flag = 0;
        end
        a = a+1;
        clear plot;
    end
    %see if the flag is still true
    if flag == 1
        stabilizationTime = 300+i;
        return
    end
end
if stabilizationTime == 0%checks if the stabilization time was actually found
    fprintf('no stabilization time found\n');
end