function [ sim, obs ] = check_data( sim, obs )
%CHECKDATA Checks if the simulated and observed arrays are correctly
%formatted for analysis
%   [sim, obs] = checkData( sim, obs ) checks if both the sim and obs array
%   are one dimensional and are the same size. If they are not it will
%   raise an error. Also will make sure that both of the vectors are
%   column vectors for use in the metric function and return both of the 
%   arrays as row vectors.

switch nargin
    case 2
        % Checking if the inputs are vectors
        if ~isvector(sim)
            error('The simulated array is not a vector.')
        end
        
        if ~isvector(obs)
            error('The observed array is not a vector.')
        end
        
        % Checking if either of the vector lengths are 1
        if (length(sim) == 1) || (length(obs) == 1)
            error('One or both of the arrays has length 1.')
        end
        
        % Checking if the lengths match
        if (length(sim) ~= length(obs))
            error('The two arrays are not the same size')
        end
        
        % Correcting the vectors if they are not column vectors
        if isrow(sim)
            sim = sim';
            warning_msg = ['The simulated array was not a column '...
                'vector and has been transposed.'];
            warning(warning_msg)
        end
        
        if isrow(obs)
            obs = obs';
            warning_msg = ['The observed array was not a column '...
                'vector and has been transposed.'];
            warning(warning_msg)
        end
        
    otherwise
        error('Both the sim and obs arrays must be provided.')

end