function ret_value = nse_mod( sim, obs, j, remove_zero, remove_neg )
% Calculates the Modified Nash-Sutcliffe Efficiency (NSE (Mod.)) for simulated and 
% observed data.
%   metric = nse_mod(sim, obs) Calculates the NSE (Mod.) error metric between the
%   simulated and observed data. j=1 in this case.
% 
%   metric = nse_mod(sim, obs, j) j is a parameter that controls the power
%   that the numerator and denominator are taken to. If higher, the impact
%   of outliers is higher. 
%
%   metric = nse_mod(sim, obs, j, remove_zero, remove_neg) Calculates the
%   NSE (Mod.) error metric between the simulated and observed data. j is a
%   parameter that controls the power that the numerator and denominator
%   are taken to. If higher, the impact of outliers is higher.  The
%   remove_zero and remove_neg values are booleans and will remove zero and 
%   negative values from the the i-th position in both the simulated and 
%   observed array if found.
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
        
        % Computing the NSE (Mod.)
        j = 1;
        a = (abs(sim - obs)).^j;
        b = (abs(obs - mean(obs))).^j;
        ret_value = 1 - (sum(a) / sum(b));
    
    case 3
        % Error checks and treatment of missing values
        [sim, obs] = check_data(sim, obs);
        [sim, obs] = remove_nan_inf(sim, obs);
        
        % Computing the NSE (Mod.)
        a = (abs(sim - obs)).^j;
        b = (abs(obs - mean(obs))).^j;
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
        
        % Computing the NSE (Mod.)
        a = (abs(sim - obs)).^j;
        b = (abs(obs - mean(obs))).^j;
        ret_value = 1 - (sum(a) / sum(b));
        
    otherwise
        error('Either 2, 3, or 5 inputs must be given.')
end