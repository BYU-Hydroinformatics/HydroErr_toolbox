function ret_value = d1_p( sim, obs, obs_bar_p, remove_zero, remove_neg )
% Calculates the Legate-McCabe Index of Agreement (D1') for simulated and 
% observed data.
%   metric = d1_p(sim, obs) Calculates the D1' error metric between the
%   simulated and observed data.
%
%   metric = d1_p(sim, obs, obs_bar_p)
% 
%   metric = d1_p(sim, obs, remove_zero, remove_neg) Calculates the D1' 
%   error metric between the simulated and observed data. The remove_zero
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
        
        % Computing the D1'
        mean_obs = mean(obs);
        a = abs(obs - sim);
        b = abs(sim - mean_obs) + abs(obs - mean_obs);
        ret_value =  1 - (sum(a) / sum(b));
    
    case 3
        % Error checks and treatment of missing values
        [sim, obs] = check_data(sim, obs);
        [sim, obs] = remove_nan_inf(sim, obs);
        
        % Computing the D1'
        a = abs(obs- sim);
        b = abs(sim - obs_bar_p) + abs(obs - obs_bar_p);
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
        
        % Computing the D1'
        a = abs(obs- sim);
        b = abs(sim - obs_bar_p) + abs(obs - obs_bar_p);
        ret_value = 1 - (sum(a) / sum(b));
        
    otherwise
        error('Either 2 or 4 inputs must be given.')
end