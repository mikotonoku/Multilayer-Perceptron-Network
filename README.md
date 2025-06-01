# Multilayer Perceptron Network
Example of two simple multilayer perceptron networks written in MATLAB.
The purpose of the task was to create a **multilayer perceptron (MLP) neural network** for **[classification](#classification-of-points-pushpin) and approximation**.

You can review the documentation for my two codes related to this task. :bookmark_tabs:

## Content:
### Classification of points
>* :page_facing_up: [MLP Network Structure](#page_facing_up-mlp-network-structure)
>* :surfer: Training Parameters
>* :space_invader: Structure of the Neural Network
>* :chart_with_downwards_trend: Training Process Progress Chart
>* :1234: Contingency Matrix (plotconfusion)
>* :paw_prints: Procedure for Testing Selected 5 Points

### Approximation of a nonlinear function
>* MLP Network Structure
>* Training Parameters
>* Structure of the Neural Network
>* Training Process Progress Chart
>* Contingency Matrix (plotconfusion)
>* Procedure for Testing Selected 5 Points
____
## Classification of points :pushpin:
For this task the goal was to create and train a **multilayer perceptron (MLP) neural network** capable of classifying points into **five groups** based on **three parameters *(x, y, z)***. The challenge was to find the **optimal network structure** (the smallest number of neurons in the hidden layer) that would allow the network to correctly classify as many points as possible, with a maximum of **two misclassified points**.

### :page_facing_up: MLP Network Structure
<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/1b7756b6-89fe-4a46-8088-be122edffc2a" width="200"></td>
    <td>
      <b><i>Input Layer:</i></b>
      <ul>
        <li><b>Number of inputs:</b> 3 inputs neurons representing the coordinates <i>x, y, z</i>.</li>
        <li><b>Function:</b> Receives input data from the file <i>databody.mat</i>.</li>
      </ul>
      <b><i>Hidden Layer:</i></b>
      <ul>
        <li><b>Number of neurons:</b> Optimized to <b>10 neurons</b> to minimize classification error.</li>
        <li><b>Neuron type:</b> Uses the <b>logsig (log-sigmoid)</b> activation function, transforming inputs for calculations in the output layer.</li>
      </ul>
      <b><i>Output Layer:</i></b>
      <ul>
        <li><b>Number of outputs:</b> 5 neurons, each representing a distinct group of points.</li>
        <li><b>Neuron type:</b> Uses the <b>softmax</b> activation function, ensuring probabilistic output for classification.</li>
      </ul>
    </td>
  </tr>
</table>

### :surfer: Training Parameters
```matlab
net.trainParam.goal = 0.001;       % Termination condition for error
net.trainParam.show = 20;          % Frequency of error display
net.trainParam.epochs = 1000;      % Maximum number of epochs
net.trainParam.max_fail = 12;      % Maximum number of failed validations
```

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/8c62337a-2d97-49ef-b441-43019f146adf" width="200"></td>
    <td>
      <b><i>Termination conditions:</i></b>
      <ul>
        <li><i><code>net.trainParam.goal = 0.001;</code></i></li>
          <ul>
            <li>Termination condition for error: Training stops if the network error reaches <b>0.001</b>.</li>
          </ul>
        <li><i><code>net.trainParam.epochs = 1000;</code></i></li>
          <ul>
            <li>Maximum number of epochs: The network can go through a maximum of <b>1000 training cycles</b>.</li>
          </ul>
        <li><i><code>net.trainParam.max_fail = 12;</code></i></li>
          <ul>
            <li>Maximum number of validation failures: Training stops if, after <b>12 consecutive failed validations</b>, no improvement occurs.</li>
          </ul>
      </ul>
    </td>
  </tr>
</table>

>:exclamation: The **criterion function** used is not explicitly stated in the given code, but it is implicitly included in the training method
*`train(net, datainnet, dataoutnet)`*.
  
### :space_invader: Structure of the Neural Network
```matlab 
% Setting parameters for splitting data into training and testing 
net.divideFcn = 'dividerand';                   % Random split 
net.divideParam.trainRatio = 0.8;               % 80% for training 
net.divideParam.valRatio = 0;                   % No validation data 
net.divideParam.testRatio = 0.2;                % 20% for testing

% Setting training parameters for the network 
net.trainParam.goal = 0.001;                    % Termination condition for error 
net.trainParam.show = 20;                       % Frequency of error display 
net.trainParam.epochs = 1000;                   % Maximum number of epochs 
net.trainParam.max_fail = 12;                   % Maximum number of failed validations
```

### :chart_with_downwards_trend: *Training Process Progress Chart:*
![image](https://github.com/user-attachments/assets/0e3a2231-1a98-48ee-a0cd-691a0da0884d)

The chart illustrates the **training process** of the neural network and the **error reduction** over training epochs.

#### Key Elements of the Chart:
:large_blue_circle: *Blue Line (Training Data Error):*
   * Shows the error on training data during each epoch.
   * Initially, the error decreases sharply, indicating the network is learning.
   * As training progresses, the error stabilizes.

:red_circle: *Red Line (Testing Data Error):*
   * Represents the error on unseen test data.
   * A stable test error suggests good generalization.
   * If the test error increases, it may indicate **overfitting**.

:paperclip: *Best Performance Point:*
   * Marks the epoch where the network achieved its lowest error.
    
:paperclip: *Overall Trend:*
   * A gradual decrease in error shows that the network is effectively adjusting its parameters.
   * If the difference between training and test error is too large, it may indicate poor generalization.

### :1234: *Contingency Matrix (plotconfusion):*
![image](https://github.com/user-attachments/assets/3b6d686f-0647-4bbc-b28c-c3617729395e)

#### Key Aspects of the Contingency Matrix:
:white_check_mark: *Diagonal Values (Green):*
   * Represent correctly classified points.
   * A high concentration of green values indicates strong classification accuracy.

:x: *Off-Diagonal Values (Red):*
   * Represent misclassified points.
   * The goal is to minimize these values to ensure high precision.
    
:trophy: *Classification Accuracy Goal:*
   * The objective is to correctly classify at least **98% of points**, allowing a maximum of **two misclassified points**.
   * The final result showed **only one misclassified point**, confirming the network's effectiveness.

#### MATLAB Code for Plotting the Confusion Matrix:
>```matlab
>% Contingency matrix
>figure;
>plotconfusion(dataoutnet, outnetsim);
>```

### :paw_prints: *Procedure for Testing Selected 5 Points:*
![image](https://github.com/user-attachments/assets/e1d85d92-af08-41f0-b5e7-1897ece094df)

:new: *Definition of New Points:*
   * The matrix `new_points` contains **5 points** with coordinates **x, y, z**.
   * These points were **not included** in the training dataset.
   * The goal is to determine **which group** each point belongs to based on the neural network classification.

:arrow_right: *Simulation of Network Outputs:*
   * Using the command `net(new_points)`, the network assigns **output values** to the new points.
   * The outputs represent **probabilities** for each group.
   * The function `vec2ind(final_output)` converts probability outputs into **group indices**.

:bar_chart: *Graphical Representation of Point Classification:*
   * The test points are visualized in a **3D graph**.
   * Each group is represented by a **different color and marker**.
   * The graph includes:
      * **Original classified points** (e.g., blue `+` for group 1).
      * **New points**, displayed with distinct colors and symbols based on their classification.

:pencil: *Interpretation of Results:*
   * If the points are correctly assigned to their respective groups, the **neural network generalizes effectively**.
   * The visualization helps verify whether the classification of new points **matches expected results**.

#### MATLAB Code for Classification of 5 New Points:
>```matlab
>% Define new test points
>new_points = [0.2, 0.5, 1, 0.4, 0.5;  
>              0.2, 0.3, 0.8, 0.7, 0.7;  
>              0.7, 0.1, 0.4, 0.6, 0.4];
>
>% Simulate network output
>final_output = net(new_points);
>final_classes = vec2ind(final_output);
>
>% Visualize classification results
>figure;
>hold on;
>plot3(data1(:,1), data1(:,2), data1(:,3), 'b+'); % Group 1
>plot3(data2(:,1), data2(:,2), data2(:,3), 'co'); % Group 2
>plot3(data3(:,1), data3(:,2), data3(:,3), 'g*'); % Group 3
>plot3(data4(:,1), data4(:,2), data4(:,3), 'r*'); % Group 4
>plot3(data5(:,1), data5(:,2), data5(:,3), 'mx'); % Group 5
>
>% Visualize new points based on classification
>colors = {'b', 'c', 'g', 'r', 'm'};
>markers = {'o', 'x', 'd', '*', '+'};
>for i = 1:size(new_points, 2)
>    class = final_classes(i);
>    plot3(new_points(1, i), new_points(2, i), new_points(3, i), ...
>        markers{class}, 'Color', colors{class}, 'MarkerSize', 10, 'LineWidth', 2);
>end
>
>grid on;
>title('Classification of New Test Points');
>xlabel('x');
>ylabel('y');
>zlabel('z');
>legend('Group 1', 'Group 2', 'Group 3', 'Group 4', 'Group 5', 'New Points');
>hold off;
>```

____
## Approximation of a nonlinear function :pushpin:
For this task the goal was to create and train a **multilayer perceptron (MLP) neural network** capable of classifying points into **five groups** based on **three parameters *(x, y, z)***. The challenge was to find the **optimal network structure** (the smallest number of neurons in the hidden layer) that would allow the network to correctly classify as many points as possible, with a maximum of **two misclassified points**.
