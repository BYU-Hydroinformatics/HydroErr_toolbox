function ret_value = irmse( sim, obs, remove_zero, remove_neg )
% Calculates the Inertial Root Mean Square Error (IRMSE) for simulated and 
% observed data.
%   metric = irmse(sim, obs) Calculates the IRMSE error metric between the
%   simulated and observed data.
%
%   metric = irmse(sim, obs, remove_zero, remove_neg) Calculates the IRMSE 
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
        
        % Computing the IRMSE
        
        % Getting the gradient of the observed data
        obs_len = length(obs);
        obs_grad = obs(2:obs_len) - obs(1:obs_len-1);
        % Standard deviation of the gradient
        obs_grad_std = std(obs_grad);
        % Divide RMSE by the standard deviation of the gradient of the observed data
        rmse_value = sqrt(mean((sim - obs).^2));
        ret_value = rmse_value / obs_grad_std;
    
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
        
        % Computing the IRMSE
        
        % Getting the gradient of the observed data
        obs_len = length(obs);
        obs_grad = obs(2:obs_len) - obs(1:obs_len-1);
        % Standard deviation of the gradient
        obs_grad_std = std(obs_grad);
        % Divide RMSE by the standard deviation of the gradient of the observed data
        rmse_value = sqrt(mean((sim - obs).^2));
        ret_value = rmse_value / obs_grad_std;
        
    otherwise
        error('Either 2 or 4 inputs must be given.')
end