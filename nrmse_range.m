function ret_value = nrmse_range( sim, obs, remove_zero, remove_neg )
% Calculates the Normalized Root Mean Square Error - Range (NRMSE (Range)) for simulated and 
% observed data.
%   metric = nrmse_range(sim, obs) Calculates the NRMSE (Range) error metric between the
%   simulated and observed data.
%
%   metric = nrmse_range(sim, obs, remove_zero, remove_neg) Calculates the NRMSE (Range) 
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
        
        % Computing the NRMSE (Range)
        rmse_value = sqrt(mean((sim - obs).^2));
        obs_max = max(obs);
        obs_min = min(obs);
        ret_value = rmse_value / (obs_max - obs_min);
    
    case 4
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
        
        % Computing the NRMSE (Range)
        rmse_value = sqrt(mean((sim - obs).^2));
        obs_max = max(obs);
        obs_min = min(obs);
        ret_value = rmse_value / (obs_max - obs_min);
        
    otherwise
        error('Either 2 or 4 inputs must be given.')
end