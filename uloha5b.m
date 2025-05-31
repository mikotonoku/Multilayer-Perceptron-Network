clear; close all;

% Loading data
data = load("datafun.mat");                                                 % Load data
x = data.x;                                                                 % Inputs
y = data.y;                                                                 % Outputs

indx_train = data.indx_train;                                               % Indices for training data
indx_test = data.indx_test;                                                 % Indices for testing data

% Setting network parameters
hidden_neurons = 10;                                                        % Number of neurons in the hidden layer
net = fitnet(hidden_neurons);                                               % Create MLP network

% Setting activation functions
net.layers{1}.transferFcn = 'tansig';                                       % Hidden layer: tangent sigmoid function
net.layers{2}.transferFcn = 'purelin';                                      % Output layer: linear function

% Setting training method
net.trainFcn = 'trainlm';                                                   % Training method: Levenberg-Marquardt

% Setting data division
net.divideFcn = 'divideind';                                                % Index-based data division
net.divideParam.trainInd = indx_train;                                      % Training data
net.divideParam.testInd = indx_test;                                        % Testing data
net.divideParam.valInd = [];                                                % No validation data

% Setting training parameters
net.trainParam.goal = 1e-4;                                                 % Termination condition for error
net.trainParam.epochs = 1000;                                               % Maximum number of epochs
net.trainParam.show = 5;                                                    % Frequency of error display

% Training the network
[net, tr] = train(net, x, y);

% Simulating network output
outnetsim = sim(net, x);

% Calculating errors
SSE_train = sse(net, y(indx_train), outnetsim(indx_train));                 % Sum of squared errors (SSE) - Training
MSE_train = mse(net, y(indx_train), outnetsim(indx_train));                 % Mean squared error (MSE) - Training
MAE_train = mae(net, y(indx_train), outnetsim(indx_train));                 % Mean absolute error (MAE) - Training

% Visualizing results 
fprintf("---- Vysledok Trenovaci -----\n");
fprintf("SSE: %d\n", SSE_train);
fprintf("MSE: %d\n", MSE_train);
fprintf("MAE: %d\n", MAE_train);
fprintf("-----------------\n");

SSE_test = sse(net, y(indx_test), outnetsim(indx_test));                    % Sum of squared errors (SSE) - Testing
MSE_test = mse(net, y(indx_test), outnetsim(indx_test));                    % Mean squared error (MSE) - Testing
MAE_test = mae(net, y(indx_test), outnetsim(indx_test));                    % Mean absolute error (MAE) - Testing

% Visualizing results
fprintf("---- Vysledok Testovaci -----\n");
fprintf("SSE: %d\n", SSE_test);
fprintf("MSE: %d\n", MSE_test);
fprintf("MAE: %d\n", MAE_test);
fprintf("-----------------\n");

% Visualizing results
figure;
plot(x(indx_train), y(indx_train), 'b+', x(indx_test), y(indx_test), 'g*');
hold on;
plot(x, outnetsim, '-or');
title(sprintf('Neural Network Output with %d Neurons', hidden_neurons));
xlabel('x'); ylabel('y');
legend('Training Data', 'Testing Data', 'Neural Network Output');
grid on;