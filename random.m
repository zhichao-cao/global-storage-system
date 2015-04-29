clear all;
%load('inputsmall.mat');
load('inputdata.mat');
combine = nchoosek(SN,K);
[total,colume] = size(combine);
random_latency = zeros(R,1);
latency_re = zeros(M,1);
random_combine = zeros(R,K);
for i=1:R
    tmp = randperm(total);
    innerset = combine(tmp(1),:);
    for j=1:M
            temp = inf;
            for l=1:K
                latnecy = D(innerset(l),j)+D(innerset(l),j);
                if(latnecy<temp)
                    temp = latnecy;
                end
            end
            latency_re(j) = temp*P(i,j);
    end
    random_latency(i) = sum(latency_re);
    random_combine(i,:) = innerset;
end
load('inputdata_best.mat');
combine = nchoosek(SN,K);
sort(random_combine,2)
combine(min_combine,:)
mean((random_latency-min_latency)./min_latency)

    
    
    