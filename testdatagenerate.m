%based on the same M,N,D generate different testing set with different P
load('inputdata.mat');
R = 50;
% the copy numbers
temp = rand(R,M);
tempSum = sum(temp,2);
test_P = zeros(R,M);
%latency matrix
for i=1:R
    test_P(i,:) = temp(i,:)./tempSum(i);
end
test_num = R;

save inputdata_test test_num test_P;