function ret_value = smape2( sim, obs, remove_zero, remove_neg )
% Calculates the Symmetric Mean Absolute Percentage Error (2) (SMAPE2) for simulated and 
% observed data.
%   metric = smape2(sim, obs) Calculates the SMAPE2 error metric between the
%   simulated and observed data.
%
%   metric = smape2(sim, obs, remove_zero, remove_neg) Calculates the SMAPE2 
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
        
        % Computing the SMAPE2
        a = sim - obs;
        b = (sim + obs) ./ 2;
        c = 100 / length(sim);
        ret_value = c * sum(abs(a ./ b));
    
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
        
        % Computing the SMAPE2
        a = sim - obs;
        b = (sim + obs) ./ 2;
        c = 100 / length(sim);
        ret_value = c * sum(abs(a ./ b));
        
    otherwise
        error('Either 2 or 4 inputs must be given.')
end