clear all
%storage node numbers
N = 20;
%gateway numbers
M = 80;
%independent object numbers
R = 10;
% the copy numbers
K = 8;
temp = rand(R,M);
tempSum = sum(temp,2);
P = zeros(R,M);
%latency matrix
D = 70*rand(N,M)+30;
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
combine = nchoosek(SN,K);
[iteration, x] = size(combine);
min_latency = zeros(R,1);
latency_re = zeros(M,1);
min_combine = zeros(R,1);
for rs=1:R
    min_latency(rs) = inf;
    for i=1:iteration
        for j=1:M
            temp = inf;
            for l=1:K
                latnecy = D(combine(i,l),j)+D(combine(i,l),j);
                if(latnecy<temp)
                    temp = latnecy;
                end
            end
            latency_re(j) = temp*P(rs,j);
            %latency_re(j) = temp;
        end
        this_latency = sum(latency_re);
        if(this_latency<min_latency(rs))
            min_latency(rs) = this_latency;
            min_combine(rs) = i;
        end
    end
end
combine(min_combine,:)
        