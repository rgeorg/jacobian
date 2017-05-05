function M_out = fullRank(M_in)
% Takes a matrix which is not full rank and removes redundant rows until it
% is

targetRank = rank(M_in);
noRows = size(M_in, 1);
newRank = NaN;

i = 1;
while (newRank ~= targetRank && i <= noRows)
    M_out = M_in;
    M_out(i,:) = [];
    newRank = rank(M_out);
    i = i + 1;
end

end

