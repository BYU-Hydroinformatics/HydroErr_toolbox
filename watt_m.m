function ret_value = watt_m( sim, obs, remove_zero, remove_neg )
% Calculates the Watterson's M (M) for simulated and 
% observed data.
%   metric = watt_m(sim, obs) Calculates the M error metric between the
%   simulated and observed data.
%
%   metric = watt_m(sim, obs, remove_zero, remove_neg) Calculates the M 
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
        
        % Computing the M
        a = 2 / pi;
        b = mean((sim - obs).^2); % MSE
        c = std(obs)^2 + std(sim)^2;
        e = (mean(sim) - mean(obs))^2;
        f = c + e;
        ret_value = a * asin(1 - (b / f));
    
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
        
        % Computing the M
        a = 2 / pi;
        b = mean((sim - obs).^2); % MSE
        c = std(obs)^2 + std(sim)^2;
        e = (mean(sim) - mean(obs))^2;
        f = c + e;
        ret_value = a * asin(1 - (b / f));
        
    otherwise
        error('Either 2 or 4 inputs must be given.')
end