function [Pimage] = fun_reLabelImage(Pimage)
%This function converts the input label (i.e. 'N', 'W', and 'S') image to a readily plottable version of
%labels (i.e. 'N' == 1, 'W' == 0, and 'S' == 2)


for ii = 1:numel(Pimage)
    if Pimage(ii) == 0
        Pimage(ii) = NaN;
        
    elseif Pimage(ii) == 1
        Pimage(ii) = NaN;
        
    elseif Pimage(ii) == 2
        Pimage(ii) = NaN;
        
    elseif Pimage(ii) == 'N'
        Pimage(ii) = 1;
        
    elseif Pimage(ii) == 'W'
        Pimage(ii) = 0;
        
    elseif Pimage(ii) == 'S'
        Pimage(ii) = 2;
        
    end
end
    
    

end