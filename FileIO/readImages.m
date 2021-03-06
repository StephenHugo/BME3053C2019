function out = readImages(varargin)
    
    if nargin==0
        w       = dir; % look at the current directory
        n       = {w.name}; % get names of all files
        n(1:2)  = []; % get rid of first two values
    else
        n=varargin;
    end

    for t=1:length(n)
 
        a = imread( n{t} ); % use cell array notation
        
        out(t).pic = a;
        
        pause(0.02) 

    end
    
end
