function vch = GetTransceivers(txrx)

    % Ensure display format is full
    format long g

    vch = zeros(size(txrx,1),3);

    for i=1:length(vch)
        for j=1:size(vch,2)
            vch(i,j) = txrx(i,j)*(1+(txrx(i,10)/100))/(2*log2(txrx(i,j+3)));
        end
    end
end
