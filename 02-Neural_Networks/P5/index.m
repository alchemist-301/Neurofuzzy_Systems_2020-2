%% Adaline vs Perceptron. Obtaining alpha.
% Toy clasification: Rabbit vs Bears
% ============Initialization===========
clc, clear all, close all

% The following Patterns represent Rabbits with target
% t = 0 for Perceptron
% t = -1 for Adaline
P1 = [1 ; 4];
P2 = [1 ; 5];
P3 = [2 ; 4];
P4 = [2 ; 5];

% The following Patterns represent Bears with target
% t = 1 for Perceptron
% t = 1 for Adaline
P5 = [3 ; 1];
P6 = [3 ; 2];
P7 = [4 ; 1];
P8 = [4 ; 2];

% Thus, our P matrix

P = [P1 P2 P3 P4 P5 P6 P7 P8];
Ptrans = P';

% Target
T_per =[0 0 0 0 1 1 1 1]; 
T_ada =[-1 -1 -1 -1 1 1 1 1];

[m, n] = size(P);
N = 1; %Number of neurons

% Random W and b
W_old = rand(N,m);
b_old = rand(N,1);

%% Calculation of the learning rate (alpha)
R = 0;

for i = 1:n
    temp = (1 / n) * P(: , i) * Ptrans(i , :);
    R = R + temp;
end

lambda_max = max(eig(R));

% For this practice We experiment different values for alfa:
alpha1 = 1/(4 * lambda_max);
alpha2 = 1/(8 * lambda_max);
alpha3 = 1/(16 * lambda_max);
%% Simuntanoues Training with Perceptron and Adaline
% For this practice we test for 20, 50 and 100 epochs with adaline
epochs = 20;

W_per = W_old;
b_per = b_old;
W_ada = W_old;
b_ada = b_old;

eStore_per = zeros(N, epochs * n);
eStore_ada1 = zeros(N, epochs * n); % For alpha 1
eStore_ada2 = zeros(N, epochs * n); % For alpha 2
eStore_ada3 = zeros(N, epochs * n); % For alpha 3
% k is the index for storing the error
k = 1;

% Training Algorithm
for i = 1:epochs
    for j = 1:n     %n is number of patterns   
        % =========== Percetrone training ===========
        a_per = hardlim(W_per * P(:,j) + b_per);
        e_per = T_per(:,j) - a_per;
        
        W_per = W_per + e_per * Ptrans(j,:);
        b_per = b_per + e_per;
        
        eStore_per(:,k) = e_per;
        k = k + 1;
        % ============ Adaline training =============
        a_ada = purelin(W_ada * P(:,j) + b_ada);

        e_ada = T_ada(:,j) - a_ada;
        W_ada =  W_ada + alpha1 * e_ada * Ptrans(j,:);
        b_ada = b_ada + alpha1 * e_ada;
        
        eStore_ada1(:,k) = e_ada;
        k = k + 1;
    end
end

k = 1;
for i = 1:epochs
    for j = 1:n     %n is number of patterns   
        % ============ Adaline training - alpha 2 =============
        a_ada = purelin(W_ada * P(:,j) + b_ada);

        e_ada = T_ada(:,j) - a_ada;
        W_ada =  W_ada + alpha2 * e_ada * Ptrans(j,:);
        b_ada = b_ada + alpha2 * e_ada;
        
        eStore_ada2(:,k) = e_ada;
        k = k + 1;
    end
end

k = 1;
for i = 1:epochs
    for j = 1:n     %n is number of patterns   
        % ============ Adaline training - alpha 3 =============
        a_ada = purelin(W_ada * P(:,j) + b_ada);

        e_ada = T_ada(:,j) - a_ada;
        W_ada =  W_ada + alpha3 * e_ada * Ptrans(j,:);
        b_ada = b_ada + alpha3 * e_ada;
        
        eStore_ada3(:,k) = e_ada;
        k = k + 1;
    end
end






