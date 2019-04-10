function result = fitLine(line)

x=1:numel(line);
figure, plot(x,line)

result = [x(:).^2 x(:) ones(size(x(:)))]\line(:);

% fit to a quadratic function

end