clear all;
%load('inputsmall.mat');
load('input1000.mat');
tic;
[tabu_combine, tabu_latency,tabu_iterations] = GSS_tabu(N,M,K,R,D,P);
toc;
load('input1000_best.mat');
combine = nchoosek(SN,K);
sort(tabu_combine,2);
combine(min_combine,:);
tabu_latency;
min_latency;
mean(tabu_iterations)
size(combine)
mean((tabu_latency-min_latency)./min_latency)