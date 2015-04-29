clear all
%storage node numbers
N = 20;
%gateway numbers
M = 80;
%independent object numbers
R = 1000;
% the copy numbers
K = 8;
temp = rand(R,M);
tempSum = sum(temp,2);
P = zeros(R,M);
%latency matrix
D = 1000*rand(N,M)+50;
SN = zeros(1,N);
gateway = zeros(1,M);
for i=1:R
    P(i,:) = temp(i,:)./tempSum(i);
end
for i=1:N
    SN(i) = i;
end
for i=1:M
    gateway(i) = i;
end

save input1000 M N K R D SN P gateway;
