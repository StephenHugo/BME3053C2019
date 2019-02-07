function [output1, output2] = someFunction( input1, input2)
% functions always begin with the word function in the first line. Any
% outputs can be specified in brackets as shown above. Inputs follow the
% name of the function in parentheses.

% When functions run, they create their own workspace. Anything you have
% defined in the command window is unavailable unless passed as an input.

% Similarly, variables created within the function will not be returned to 
% the common workspace once the function is done running unless they are 
% specified as outputs.

output1 = internalFunction( input1 + input2 );

output2 = nestedFunction( input1 .* input2 );

    function out = nestedFunction(in)
       
        out = in/5 + output1;
        
    end

end

function out = internalFunction(in)

out = in*5;

end