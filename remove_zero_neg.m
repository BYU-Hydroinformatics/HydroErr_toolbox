function [ sim, obs ] = remove_zero_neg( sim, obs, remove_zero, remove_neg )
%REMOVE_VALUES removes zeros and negatives
%   sim, obs = removeValues(sim, obs, remove_neg, remove_zero) Removes
%   negative and zero values from the two arrays at the i-th position of
%   the zero or negative value from both the simulated and observed array.

switch nargin
    case 4
        if remove_neg
            % Finding the negative indices and combining them
            sim_neg = sim >= 0;
            obs_neg = obs >= 0;
            neg_indices = and(sim_neg, obs_neg);
            % Removing the negative indices
            sim = sim(neg_indices);
            obs = obs(neg_indices);
            
            if ~(all(neg_indices == 1))
                neg_warning = ['There were negative values in one of '...
                    'the arrays and they have been removed'];
                warning(neg_warning)
            end
        end
        
        if remove_zero
            % Finding the zero indices and combining them
            sim_zero = sim ~= 0;
            obs_zero = obs ~= 0;
            zero_indices = and(sim_zero, obs_zero);
            % Removing the zero indices
            sim = sim(zero_indices);
            obs = obs(zero_indices);
            
            if ~(all(zero_indices == 1))
                zero_warning = ['There were zero values in one of the '...
                    'arrays and they have been removed'];
                warning(zero_warning)
            end
        end
        
    otherwise
        error('All 4 function inputs must be satisfied.')
end