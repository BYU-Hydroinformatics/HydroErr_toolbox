function ret_value = h6_rmshe( sim, obs, k, remove_zero, remove_neg )
% Calculates the Root Mean Square H6 Error (H6 (RMSHE)) for simulated and observed data.
%   metric = h6_rmshe(sim, obs) Calculates the H6 (RMSHE) error metric 
%   between the simulated and observed data with k=1.
%
%   metric = h6_rmshe(sim, obs, k) k is a float or integer input that
%   determines the power that the bottom term will be taken to. 
% 
%   metric = h6_rmshe(sim, obs, k, remove_zero, remove_neg) The remove_zero
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
        
        % Computing the H6 (RMSHE)
        k=1;
        top = sim ./ obs - 1;
        bot = power(0.5 * (1 + power(sim ./ obs, k)), 1 / k);
        h = top ./ bot;
        ret_value = sqrt(mean(h.^2));
    
    case 3
        % Error checks and treatment of missing values
        [sim, obs] = check_data(sim, obs);
        [sim, obs] = remove_nan_inf(sim, obs);
        
        % Computing the H6 (MHE)
        top = sim ./ obs - 1;
        bot = power(0.5 * (1 + power(sim ./ obs, k)), 1 / k);
        h = top ./ bot;
        ret_value = sqrt(mean(h.^2));
        
        
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
        
        % Computing the H6 (RMSHE)
        top = sim ./ obs - 1;
        bot = power(0.5 * (1 + power(sim ./ obs, k)), 1 / k);
        h = top ./ bot;
        ret_value = sqrt(mean(h.^2));
        
    otherwise
        error('Either 2, 3, or 5 inputs must be given.')
end