function [ sim, obs ] = remove_nan_inf( sim, obs )
%REMOVE_NAN_INF removes NaN and inf values
%   sim, obs = removeValues(sim, obs) Removes NaN and inf values from 
%   the two arrays at the i-th position of the NaN or inf value from 
%   both the simulated and observed array. Also raises a warning if NaN or
%   inf values are found.

switch nargin
    case 2
        % Finding the NaN indices and combining them
        sim_nan = ~isnan(sim);
        obs_nan = ~isnan(obs);
        nan_indices = and(sim_nan, obs_nan);
        sim = sim(nan_indices);
        obs = obs(nan_indices);
        
        % Finding the inf indices and combining them
        sim_inf = ~isinf(sim);
        obs_inf = ~isinf(obs);
        inf_indices = and(sim_inf, obs_inf);
        sim = sim(inf_indices);
        obs = obs(inf_indices);
        
        if ~(all(nan_indices == 1))
            nan_warning = ['There were NaN values in one of the arrays '...
                'and they have been removed'];
            warning(nan_warning)
        end
        
        if ~(all(inf_indices == 1))
            inf_warning = ['There were inf values in one of the arrays '...
                'and they have been removed'];
            warning(inf_warning)
        end
        
    otherwise
        error('The 2 function inputs must be satisfied.')

end

