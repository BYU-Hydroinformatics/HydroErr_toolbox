function ret_value = lm_index(sim, obs, obs_bar_p, remove_zero, remove_neg)
% Calculates the Legate-McCabe Efficiency Index (E1') for simulated and 
% observed data.
%   metric = lm_index(sim, obs) Calculates the E1' error metric between the
%   simulated and observed data. The obs_bar_p value is the mean.
%
%   metric = lm_index(sim, obs, obs_bar_p) obs_bar_p can be set as a 
%   seasonal or other selected average.
% 
%   metric = lm_index(sim, obs, remove_zero, remove_neg) The remove_zero
%   and remove_neg values are booleans and will remove zero and negative
%   values from the the i-th position in both the simulated and observed
%   array if found.
% 
%   See https://waderoberts123.github.io/Hydrostats/ for a more complete
%   description of this metric.
% 
%   Brigham Young University Civil & Environmental Engineering

switch nargin
    case 2
        % Error checks and treatment of missing values
        [sim, obs] = check_data(sim, obs);
        [sim, obs] = remove_nan_inf(sim, obs);
        
        % Computing the E1'
        mean_obs = mean(obs);
        a = abs(sim - obs);
        b = abs(obs - mean_obs);
        ret_value = 1 - (sum(a) / sum(b));
    
    case 3
        % Error checks and treatment of missing values
        [sim, obs] = check_data(sim, obs);
        [sim, obs] = remove_nan_inf(sim, obs);
        
        % Computing the E1'
        a = abs(sim - obs);
        b = abs(obs - obs_bar_p);
        ret_value = 1 - (sum(a) / sum(b));
        
    case 5
        % Check if remove_nan and remove_zero are booleans
        if (remove_zero ~= 0) && (remove_zero ~= 1)
            error('The remove_zero variable is a boolean.')
        end
        
        if (remove_neg ~= 0) && (remove_neg ~= 1)
            error('The remove_neg variable is a boolean.')
        end
        
        % Error checks and treatment of missing values
        [sim, obs] = check_data(sim, obs);
        [sim, obs] = remove_nan_inf(sim, obs);
        [sim, obs] = remove_zero_neg(sim, obs, remove_zero, remove_neg);
        
        % Computing the E1'
        a = abs(sim - obs);
        b = abs(obs - obs_bar_p);
        ret_value = 1 - (sum(a) / sum(b));
        
    otherwise
        error('Either 2, 3, or 5 inputs must be given.')
end