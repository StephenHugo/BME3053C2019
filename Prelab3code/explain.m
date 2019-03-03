% this is an example of a script
% variables contain data of some type
x= 1;
st='string'; % <--- ; suppresses matlab output
y = 4e5 % <--- ; is missing

% when we use functions, you input variables in ()
x=1:6; % this : operator takes 1 step from 1 to 6 and makes a vector
m=mean(x)

% pop up an image
image % no parantheses, so matlab has a default image that says
% you messed up

% her are some image functions to display things
r= randn(100);
image(r)
figure, imagesc(r) % by default, making multiple function calls to 
%display images will overwrite previous images, adding figure first makes a
%new figure

nhist(r(:), 10) % the 10 is a second argument to the nhist function

whos
%pause(2)
close all
% the number of inputs and outputs will change based on the function
% when you call a function, matlab creates it's own function space for
% variables.
[a,b,c]=calibrateLab3(1,2,3,4,5,6);

plot(x,x+1)
ch = get(gca,'Children'); % gets the plotted object from the current axes
get(ch,'LineWidth') % returns the linewidth of the line tagged by ch





