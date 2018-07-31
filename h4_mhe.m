function ret_value = h4_mhe( sim, obs, remove_zero, remove_neg )
% Calculates the Mean H4 Error (H4 (MHE)) for simulated and 
% observed data.
%   metric = h4_mhe(sim, obs) Calculates the H4 (MHE) error metric between the
%   simulated and observed data.
%
%   metric = h4_mhe(sim, obs, remove_zero, remove_neg) Calculates the H4 (MHE) 
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
        
        % Computing the H4 (MHE)
        h = (sim - obs) ./ sqrt(sim .* obs);
        ret_value = mean(h);
    
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
        
        % Computing the H4 (MHE)
        h = (sim - obs) ./ sqrt(sim .* obs);
        ret_value = mean(h);
        
    otherwise
        error('Either 2 or 4 inputs must be given.')
end