function readImages
    
w       = dir;
n       = {w.name};
n(1:2)  = [];

fi(1)

for t=1:length(n)
   a = imread(['im',num2str(t),'.jpg']);
   
   imagesc(a)
   
   pause(0.02) 
    
end

end