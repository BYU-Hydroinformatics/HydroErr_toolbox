function ret_value = kge_2012( sim, obs, s, remove_zero, remove_neg )
% Calculates the Kling-Gupta Efficiency (2012) (KGE (2012)) for simulated and 
% observed data.
%   metric = kge_2012(sim, obs) Calculates the KGE (2012) error metric
%   between the simulated and observed data. s=[1, 1, 1] in this case.
%
%   metric = kge_2012(sim, obs, s) Calculates the KGE (2012) error metric
%   between the simulated and observed data. s is a vector of length three
%   representing the scaling factors to be used for re-scaling the
%   Pearson product-moment correlation coefficient (r), gamma, and beta,
%   respectively.
%
%   metric = kge_2012(sim, obs, s, remove_zero, remove_neg) Calculates the
%   KGE (2012) error metric between the simulated and observed data. The
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
        
        % Computing the KGE (2012)
        s = [1, 1, 1];
        
        % Means
        sim_mean = mean(sim);
        obs_mean = mean(obs);
        
        % Standard Deviations
        sim_sigma = std(sim);
        obs_sigma = std(obs);
        
        % Pearson R
        pr = corr(sim, obs);
        
        % Ratio between mean of simulated and observed data
        beta = sim_mean / obs_mean;
        
        % CV is the coefficient of variation (standard deviation / mean)
        sim_cv = sim_sigma / sim_mean;
        obs_cv = obs_sigma / obs_mean;
        
        % Variability Ratio, or the ratio of simulated CV to observed CV
        gam = sim_cv / obs_cv;
        
        if (obs_mean ~= 0) && (obs_sigma ~= 0)
            kge = 1 - sqrt((s(1)*(pr-1))^2+(s(2)*(gam-1))^2+(s(3)*(beta-1))^2);
        else
            if (obs_mean == 0)
                the_warning = ['Warning: The observed data mean is 0. '...
                    'Therefore, Beta is infinite and the KGE value '...
                    'cannot be computed.'];
                warn(the_warning)
            end
            if (obs_sigma == 0)
                the_warning = ['Warning: The observed data standard '...
                    'deviation is 0. Therefore, Beta is infinite and '...
                    'the KGE value cannot be computed.'];
                warn(the_warning)
            end
            kge = nan;
        end
        ret_value = kge;
    
    case 3
        % Error checks and treatment of missing values
        [sim, obs] = check_data(sim, obs);
        [sim, obs] = remove_nan_inf(sim, obs);
        
        % Computing the KGE (2012)
        
        % Means
        sim_mean = mean(sim);
        obs_mean = mean(obs);
        
        % Standard Deviations
        sim_sigma = std(sim);
        obs_sigma = std(obs);
        
        % Pearson R
        pr = corr(sim, obs);
        
        % Ratio between mean of simulated and observed data
        beta = sim_mean / obs_mean;
        
        % CV is the coefficient of variation (standard deviation / mean)
        sim_cv = sim_sigma / sim_mean;
        obs_cv = obs_sigma / obs_mean;
        
        % Variability Ratio, or the ratio of simulated CV to observed CV
        gam = sim_cv / obs_cv;
        
        if (obs_mean ~= 0) && (obs_sigma ~= 0)
            kge = 1 - sqrt((s(1)*(pr-1))^2+(s(2)*(gam-1))^2+(s(3)*(beta-1))^2);
        else
            if (obs_mean == 0)
                the_warning = ['Warning: The observed data mean is 0. '...
                    'Therefore, Beta is infinite and the KGE value '...
                    'cannot be computed.'];
                warn(the_warning)
            end
            if (obs_sigma == 0)
                the_warning = ['Warning: The observed data standard '...
                    'deviation is 0. Therefore, Beta is infinite and '...
                    'the KGE value cannot be computed.'];
                warn(the_warning)
            end
            kge = nan;
        end
        ret_value = kge;
        
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
        
        % Computing the KGE (2012)
        
        % Computing the KGE (2012)
        
        % Means
        sim_mean = mean(sim);
        obs_mean = mean(obs);
        
        % Standard Deviations
        sim_sigma = std(sim);
        obs_sigma = std(obs);
        
        % Pearson R
        pr = corr(sim, obs);
        
        % Ratio between mean of simulated and observed data
        beta = sim_mean / obs_mean;
        
        % CV is the coefficient of variation (standard deviation / mean)
        sim_cv = sim_sigma / sim_mean;
        obs_cv = obs_sigma / obs_mean;
        
        % Variability Ratio, or the ratio of simulated CV to observed CV
        gam = sim_cv / obs_cv;
        
        if (obs_mean ~= 0) && (obs_sigma ~= 0)
            kge = 1 - sqrt((s(1)*(pr-1))^2+(s(2)*(gam-1))^2+(s(3)*(beta-1))^2);
        else
            if (obs_mean == 0)
                the_warning = ['Warning: The observed data mean is 0. '...
                    'Therefore, Beta is infinite and the KGE value '...
                    'cannot be computed.'];
                warn(the_warning)
            end
            if (obs_sigma == 0)
                the_warning = ['Warning: The observed data standard '...
                    'deviation is 0. Therefore, Beta is infinite and '...
                    'the KGE value cannot be computed.'];
                warn(the_warning)
            end
            kge = nan;
        end
        ret_value = kge;
        
    otherwise
        error('Either 2, 3, or 5 inputs must be given.')
end