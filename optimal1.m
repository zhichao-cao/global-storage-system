clear all;
tic;
load('input1000.mat');
combine = nchoosek(SN,K);
[iteration, x] = size(combine);
% R = test_num;
% P = test_P;
min_latency = zeros(R,1);
latency_re = zeros(M,1);
min_combine = zeros(R,1);
for rs=1:R
    rs
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
        end
        this_latency = sum(latency_re);
        if(this_latency<min_latency(rs))
            min_latency(rs) = this_latency;
            min_combine(rs) = i;
        end
    end
end
toc;
out = combine(min_combine,:);
% test_min_combine = min_combine;
% test_min_latency = min_latency;

save input1000_best min_combine min_latency;
        