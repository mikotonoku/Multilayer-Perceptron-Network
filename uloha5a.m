load databody

h = figure;
plot3(data1(:,1), data1(:,2), data1(:,3), 'b+');                            % Visualization of the first group of points
hold on
plot3(data2(:,1), data2(:,2), data2(:,3), 'co');                            % Visualization of the second group of points
plot3(data3(:,1), data3(:,2), data3(:,3), 'g*');                            % Visualization of the third group of points
plot3(data4(:,1), data4(:,2), data4(:,3), 'r*');                            % Visualization of the fourth group of points
plot3(data5(:,1), data5(:,2), data5(:,3), 'mx');                            % Visualization of the fifth group of points

grid on
title('Data points') 
xlabel('x') 
ylabel('y')
zlabel('z')

% Combining all data for training
data_groups = {'data1', 'data2', 'data3', 'data4', 'data5'};
all_data = [];
for i = 1:numel(data_groups)
    group_data = eval(data_groups{i});                                      % Retrieving data from the group
    all_data = [all_data; group_data];                                      % Merging data into a single matrix
end

% Input and output data for training the neural network
datainnet = all_data';                                                      % Transposing data for compatibility with the network
group_size = size(data1, 1);                                                % Number of points in each group
dataoutnet = zeros(numel(data_groups), group_size * numel(data_groups));    % Initializing the binary matrix

for i = 1:numel(data_groups)
    dataoutnet(i, (1:group_size) + (i-1) * group_size) = 1;                 % Setting output for the group
end

% Creating the neural network structure
hidden_neurons = 10;                                                        % Initial number of neurons in the hidden layer
net = patternnet(hidden_neurons);                                           % Creating the network


% Neural network structure
% Setting parameters for splitting data into training and testing
net.divideFcn = 'dividerand';                                               % Random split
net.divideParam.trainRatio = 0.8;                                           % 80% for training
net.divideParam.valRatio = 0;                                               % No validation data
net.divideParam.testRatio = 0.2;                                            % % 20% for testing

% Setting training parameters for the network
net.trainParam.goal = 0.001;                                                % Termination condition based on error
net.trainParam.show = 20;                                                   % Frequency of displaying error
net.trainParam.epochs = 1000;                                               % Maximum number of epochs
net.trainParam.max_fail = 12;                                               % Maximum number of failed validations

% Training the neural network and returning training data
[net, tr] = train(net, datainnet, dataoutnet);

% Displaying the neural network structure
view(net)

% Simulating the neural network output for training data
outnetsim = sim(net, datainnet);

% Calculating the neural network error
err = (outnetsim - dataoutnet);

% Percentage of misclassified points
confusion_matrix = confusion(dataoutnet, outnetsim);

% Contingency matrix
figure;
plotconfusion(dataoutnet, outnetsim);

% Classifying 5 new points into groups
new_points = [0.2, 0.5, 1, 0.4, 0.5;
              0.2, 0.3, 0.8, 0.7, 0.7;
              0.7, 0.1, 0.4, 0.6, 0.4];

final_output = net(new_points);
final_classes = vec2ind(final_output);                                      % Selecting the class with the highest probability

% Graphical representation of the classification of new points
figure;
hold on;
plot3(data1(:,1), data1(:,2), data1(:,3), 'b+');                            % Group 1
plot3(data2(:,1), data2(:,2), data2(:,3), 'co');                            % Group 2
plot3(data3(:,1), data3(:,2), data3(:,3), 'g*');                            % Group 3
plot3(data4(:,1), data4(:,2), data4(:,3), 'r*');                            % Group 4
plot3(data5(:,1), data5(:,2), data5(:,3), 'mx');                            % Group 5

% Visualization of new points based on classification
colors = {'b', 'c', 'g', 'r', 'm'};
markers = {'o', 'x', 'd', '*', '+'};
for i = 1:size(new_points, 2)
    class = final_classes(i);
    plot3(new_points(1, i), new_points(2, i), new_points(3, i), ...
        markers{class}, 'Color', colors{class}, 'MarkerSize', 10, 'LineWidth', 2);
end

grid on;
title('Classification of new test points');
xlabel('x');
ylabel('y');
zlabel('z');
legend('Group 1', 'Group 2', 'Group 3', 'Group 4', 'Group 5', 'New points');
hold off;