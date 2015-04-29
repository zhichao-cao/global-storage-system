clear all;
%load('inputsmall.mat');
load('inputdata.mat');
SN_latency = sum(D,2);
[value,index] = sort(SN_latency);
iterations = round(factorial(N)/(N*N));
tabus = 40;
tabu_combine = zeros(R,K);
tabu_latency = zeros(R,1);
latency_re = zeros(M,1);
stop_iterations = 1000;
tabu_iterations = zeros(R,1);
for i=1:R
    innerset = index(1:K,1);
    outerset = index(K+1:N,1);
    innertabu = zeros(K,1);
    outertabu = zeros(N-K,1);
    now_best = inf;
    before_best = inf;
    now_SN = zeros(K);
    before_SN = zeros(K,1);
    in_choose = 1;
    out_choose = 1;
    before_intabu = 0;
    before_outtabu = 0;
    best_iteration = 0;
    
    %start the tabu search for one object
    for j=1:iterations
        %stop condition
%         in_choose
%         out_choose
%         innerset
%         now_best
        
        if(j-best_iteration>=stop_iterations)
            break;
        end
        %for the combination now, we calculate the mininal latency
        SN_AVlatency = zeros(K,1);
        SN_number = zeros(K,1);
        for l=1:M
            temp = inf;
            for o=1:K
                latnecy = D(innerset(o),l)+D(innerset(o),l);
                if(latnecy<temp)
                    temp = latnecy;
                    SN_choose = o;
                end
            end
            latency_re(l) = temp*P(i,l);
            SN_AVlatency(SN_choose) = SN_AVlatency(SN_choose)+latency_re(l);
            SN_number(SN_choose) = SN_number(SN_choose)+1;
        end
        this_latency = sum(latency_re);
        SN_AVlatency = SN_AVlatency./SN_number;
        %when this iteration return a better results, remember the best,
        %and set the tabu elemets in matrix
        now_best = this_latency;
        now_SN = innerset;
        innertabu(in_choose) = tabus;
        outertabu(out_choose) = tabus;
        if(this_latency<before_best)
            before_best = this_latency;
            before_SN = innerset;
            before_intabu = in_choose;
            before_outtabu = out_choose;
            best_iteration = j;
        end
        %this section is used to select the exchange element in the
        %outerset.
        out_next = randperm(N-K);
        out_choose = 0;
        in_choose = 0;
        for jj=1:N-K
            if(outertabu(out_next(jj))<=0)
                out_choose = out_next(jj);
                break;
            end
        end
        %if all the elements in outset are forbidon, try to release the
        %best one
        if(out_choose==0&&jj==N-K)
            out_choose = before_outtabu;
        end
        %deal with the inset selection
        in_next = randperm(K);
%         in_choose = in_next(kk);
        for kk=1:K
            if(innertabu(in_next(kk))<=0)
                in_choose = in_next(kk);
                break;
            end
        end
        if(in_choose==0&&kk==K)
            [value,location] = sort(SN_AVlatency);
            in_choose = location(K);
        end
        %decrease the tabu matrix by 1
        innertabu = innertabu -1;
        outertabu= outertabu -1;
        
        %do the exchange to get the next neighbourhood
        temp = innerset(in_choose);
        innerset(in_choose) = outerset(out_choose);
        outerset(out_choose) = temp;
    end
    tabu_iterations(i) = j;
    tabu_combine(i,:) = before_SN;
    tabu_latency(i) = before_best;
end
load('inputdata_best.mat');
combine = nchoosek(SN,K);
sort(tabu_combine,2)
combine(min_combine,:)
tabu_latency
min_latency
mean(tabu_iterations)
size(combine)
mean((tabu_latency-min_latency)./min_latency)

