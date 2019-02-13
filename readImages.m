function out = readImages
    
w       = dir; % look at the current directory
n       = {w.name}; % get names of all files
n(1:2)  = []; % get rid of first two values

fi(1) % default image with formating

for t=1:length(n)
%    a = imread(['images/im',num2str(t),'.jpg']);
    a = imread( n{t} ); % use cell array notation
   
    m = mean(a(:)); % calculate mean of entire image
   imagesc(a>3*m)
   
   pause(0.02) 
    
end
out = a/m;
end