function range = createBandwithRange(varargin)

  % Ensure full precision display
    format long g

    % Number of intervals
    n = length(varargin);
    
    % Initialize matrix
    intervals = zeros(n, 2);
 
    % Fill matrix
    for i = 1:n
        interval = varargin{i};
        
        if length(interval) ~= 2
            error('Only 2-number interval allowed.');
        end
        
        intervals(i, :) = interval;
    end

 range(1)=max(intervals(:,1));
 range(2)=min(intervals(:,2));

end
