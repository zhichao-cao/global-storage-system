clear all;
tic;
load('input1000.mat');
load('input1000_best.mat');
% load('inputdata_test.mat');
% load('inputdata_test_best');
combine = nchoosek(SN,K);
choosen = combine(min_combine,:);
test_num = 300;
R = 700;
test_P = P(701:1000,:);
choosen_test = zeros(test_num,K);
training = cell(N,1);
train_size = zeros(N,1);
ratio = 0.005;
for i=1:N
    training{i,1} = [];
end

for i=1:R
    for j=1:K
        training{choosen(i,j),1} = [training{choosen(i,j),1};P(i,:)];
    end
end

for i=1:N
    [train_size(i),wide] = size(training{i,1});
end
distance = zeros(test_num,N);
for j=1:test_num
    for i=1:N
        if(train_size(i)==0)
            distance(j,i)=inf;
            continue;
        end
        numbers = round(train_size(i)*ratio);
        temp = repmat(test_P(j,:),train_size(i),1);
        %distance(j,i) = sum(sum((temp - training{i,1}).*(temp - training{i,1}),1),2)/train_size(i);
        select1 = sqrt(sum((temp - training{i,1}).*(temp - training{i,1}),2));
        select2 = select1(1:numbers);
        distance(j,i) = sum(select2)/numbers;
    end
    [value,index] = sort(distance(j,:));
    choosen_test(j,:) = sort(index(1:K));
end

Knearest_latency = zeros(test_num,1);
latency_re = zeros(M,1);
for i=1:test_num
    innerset = choosen_test(i,:);
    for j=1:M
            temp = inf;
            for l=1:K
                latnecy = D(innerset(l),j)+D(innerset(l),j);
                if(latnecy<temp)
                    temp = latnecy;
                end
            end
            latency_re(j) = temp*test_P(i,j);
    end
    Knearest_latency(i) = sum(latency_re);
end
toc;
mean(Knearest_latency)
test_min_latency = min_latency(701:1000,:);
mean((Knearest_latency-test_min_latency)./test_min_latency)

    
    
    
    
    
    
    
    

