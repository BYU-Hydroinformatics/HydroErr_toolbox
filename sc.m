function ret_value = sc( sim, obs, remove_zero, remove_neg )
% Calculates the Spectral Correlation (SC) for simulated and 
% observed data.
%   metric = sc(sim, obs) Calculates the SC error metric between the
%   simulated and observed data.
%
%   metric = sc(sim, obs, remove_zero, remove_neg) Calculates the SC 
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
        
        % Computing the SC
        a = dot(obs - mean(obs), sim - mean(sim));
        b = norm(obs - mean(obs));
        c = norm(sim - mean(sim));
        e = b * c;
        ret_value = acos(a / e);
    
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
        
        % Computing the SC
        a = dot(obs - mean(obs), sim - mean(sim));
        b = norm(obs - mean(obs));
        c = norm(sim - mean(sim));
        e = b * c;
        ret_value = acos(a / e);
        
    otherwise
        error('Either 2 or 4 inputs must be given.')
end