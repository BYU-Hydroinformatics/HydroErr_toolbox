function ret_value = mase( sim, obs, m, remove_zero, remove_neg )
% Calculates the Mean Absolute Scaled Error (MASE) for simulated and 
% observed data.
%   metric = mase(sim, obs) Calculates the MASE error metric between 
%   the simulated and observed data. m=1 in this case. 
% 
%   metric = mase(sim, obs, m) Calculates the MASE error metric between 
%   the simulated and observed data. m is an integer input indicating the 
%   seasonal period m. If not seasonal, set m to 1.
%
%   metric = mase(sim, obs, m, remove_zero, remove_neg) Calculates the 
%   MASE error metric between the simulated and observed data. m is an 
%   integer input indicating the seasonal period m. If not seasonal, set m 
%   to 1.The remove_zero and remove_neg values are booleans and will remove 
%   zero and negative values from the the i-th position in both the 
%   simulated and observed array if found.
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
        
        % Computing the MASE
        m = 1;
        START = m + 1;
        END = length(sim) - m;
        a = mean(abs(sim - obs));
        b = abs(obs(START:length(obs)) - obs(1:END));
        ret_value = a / (sum(b) / END);
    
    case 3
        % Error checks and treatment of missing values
        [sim, obs] = check_data(sim, obs);
        [sim, obs] = remove_nan_inf(sim, obs);
        
        % Computing the MASE
        START = m + 1;
        END = length(sim) - m;
        a = mean(abs(sim - obs));
        b = abs(obs(START:length(obs)) - obs(1:END));
        ret_value = a / (sum(b) / END);
    
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
        
        % Computing the MASE
        START = m + 1;
        END = length(sim) - m;
        a = mean(abs(sim - obs));
        b = abs(obs(START:length(obs)) - obs(1:END));
        ret_value = a / (sum(b) / END);
        
    otherwise
        error('Either 2 or 4 inputs must be given.')
end