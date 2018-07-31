function ret_value = dmod( sim, obs, j, remove_zero, remove_neg )
% Calculates the Modified Index of Agreement (d (Mod.)) for simulated and 
% observed data.
%   metric = dmod(sim, obs) Calculates the d (Mod.) error metric between 
%   the simulated and observed data. j=1 in this case. 
% 
%   metric = dmod(sim, obs, j) J is a parameter that controls the
%   influence of outliers. The lower j, the less impact of outliers. When j
%   is one, this is the same metric as the d1 metric. 
%
%   metric = dmod(sim, obs, remove_zero, remove_neg) Calculates the d (Mod.) 
%   error metric between the simulated and observed data. J is a parameter 
%   that controls the influence of outliers. The lower j, the less impact 
%   of outliers. When j is one, this is the same metric as the d1 metric. 
%   The remove_zero and remove_neg values are booleans and will remove zero 
%   and negative values from the the i-th position in both the simulated 
%   and observed array if found.
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
        
        % Computing the d (Mod.)
        j = 1;
        a = (abs(sim - obs)).^j;
        b = abs(sim - mean(obs));
        c = abs(obs - mean(obs));
        e = (b + c).^j;
        ret_value = 1 - (sum(a) / sum(e));
    
    case 3
        % Error checks and treatment of missing values
        [sim, obs] = check_data(sim, obs);
        [sim, obs] = remove_nan_inf(sim, obs);
        
        % Computing the d (Mod.)
        a = (abs(sim - obs)).^j;
        b = abs(sim - mean(obs));
        c = abs(obs - mean(obs));
        e = (b + c).^j;
        ret_value = 1 - (sum(a) / sum(e));
    
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
        
        % Computing the d (Mod.)
        a = (abs(sim - obs)).^j;
        b = abs(sim - mean(obs));
        c = abs(obs - mean(obs));
        e = (b + c).^j;
        ret_value = 1 - (sum(a) / sum(e));
        
    otherwise
        error('Either 2 or 4 inputs must be given.')
end