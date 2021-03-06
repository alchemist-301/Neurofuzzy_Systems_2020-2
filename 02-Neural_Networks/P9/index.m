% Practice 9: by Pablo Dom�nguez Dur�n 
% Instructions:
% � 1. Work with the values of the problem that separates bears from
% rabbits. Keep the patterns for bears the same and change the values
% for the rabbits such that they round the values of the bears
% � 2. Propose a two layer neural network with 2 neurons in the first layer and
% 1 neuron in the second layer
% � 3. Train the network to find the values of W and b in both layer such that
% the newtwork separates the points
% � 4. Test the network in the cartesian plane to show the classification. Plot
% the 8 patterns used to train the network with a different color or symbol.
% � 5. If the network does not separate the two classes adapt: Alpha and
% number of epochs and if it does not work, add a neuron in the first layer
% � 6. Generate a document adding the code, the graph and explain wich
% options did you try for Alpha, number of epochs, number of layers

% ============Initialization===========
clc, clear all, close all

% The following Patterns represent Rabbits with target
% t = -1 
P1 = [2 ; 2];
P2 = [3 ; 3];
P3 = [4 ; 3];
P4 = [5 ; 2];

% The following Patterns represent Bears with target
% t = 1 
P5 = [3 ; 1];
P6 = [3 ; 2];
P7 = [4 ; 1];
P8 = [4 ; 2];

% ============= Network Design ===============
% Thus, our P matrix
P = [P1 P2 P3 P4 P5 P6 P7 P8];
Ptrans = P';

% Target
T =[-1 -1 -1 -1 1 1 1 1];

[m, n] = size(P);
N_L1 = 2;   %Number of neurons First Layer
N_L2 = 1;   %Number of neurons Second Layer    

% =========== Variables ==============
% For first layer: 2 neurons
W1_old = rand(N_L1, m);
b1_old = rand(N_L1, 1);

% For seconde layer: 1 neuron
W2_old = rand(N_L2, N_L1);
b2_old = rand(N_L2, 1);



%% Training
%   Vars for the training
alpha = 0.1;
epochs = 50;

W1 = W1_old;
b1 = b1_old;
W2 = W2_old;
b2 = b2_old;

for i = 1 : epochs
    for j = 1 : n
        %=========BACKPROGATION ALGORITHM==========
        % Step 1: propagate forwards
        a1 = logsig(W1 * P(:,j) + b1);
        a2 = purelin(W2 * a1 + b2);
        
        e = T(j) - a2;
        
        %Step 2: propagate sensitivities backwards
        s2 = - 2 * 1 * e;  %First derivative of purelin, a2.
        s1 = [(1 - a1(1)) * a1(1), 0; 0, (1 - a1(2)) * a1(2)] * W2' * s2;
        
        %Step 3: Calculate new W's and b's using learning rules
        W2 = W2 - alpha * s2 * a1';
        b2 = b2 - alpha * s2;
        
        W1 = W1 - alpha * s1 * Ptrans(j,:);
        b1 = b1 - alpha * s1;
    end
end

% Plotting patterns
figure(1)
s = strcat('Alpha = ', num2str(alpha), ', Epochs = ', num2str(epochs));
title(s);
hold on
for i=1:4
   scatter(P(1,i),P(2,i),'g','LineWidth',1.5)
   hold on
end
for i=5:n
   scatter(P(1,i),P(2,i),'r','LineWidth',1.5)
   hold on
end
grid on

% Testing
x0 = 0:0.1:6;
y0 = 0:0.1:4;

for i = 1 : length(x0)
    for j = 1 : length(y0)
        a1 = logsig(W1 * [x0(i); y0(j)] + b1);
        a2 = purelin(W2 * a1 + b2);
        
        if(a2 >= 0)
            plot(x0(i), y0(j), 'xr');
        else
            plot(x0(i), y0(j), 'xg');
        end
        hold on
   end
end
grid on


