# Multilayer Perceptron Network
Example of two simple multilayer perceptron networks written in MATLAB.
The purpose of the task was to create a **multilayer perceptron (MLP) neural network** for **classification and approximation**.

You can review the documentation for my two codes related to this task. :bookmark_tabs:

*Content of the documentation* :arrow_down:
## Content:
### Classification of points
>* :page_facing_up: [MLP Network Structure *CLASSIFICATION*](#page_facing_up-mlp-network-structure-classification)
>* :surfer: [Training Parameters *CLASSIFICATION*](#surfer-training-parameters-classification)
>   * [Termination Conditions *CLASSIFICATION*](#termination-conditions-classification)
>* :space_invader: [Structure of the Neural Network](#space_invader-structure-of-the-neural-network)
>* :chart_with_downwards_trend: [Training Process Progress Chart *CLASSIFICATION*](#chart_with_downwards_trend-training-process-progress-chart-classification)
>* :1234: [Contingency Matrix (plotconfusion)](#1234-contingency-matrix-plotconfusion)
>* :paw_prints: [Procedure for Testing Selected 5 Points](#paw_prints-procedure-for-testing-selected-5-points)

### Approximation of a nonlinear function
>* :page_facing_up: [MLP Network Structure *APPROXIMATION*](#page_facing_up-mlp-network-structure-approximation)
>* :repeat: [Description of Input and Output Data](#repeat-description-of-input-and-output-data)
>* :surfer: [Training Parameters *APPROXIMATION*](#surfer-training-parameters-approximation)
>   * [Termination Conditions *APPROXIMATION*](#termination-conditions-approximation)
>* :chart_with_downwards_trend: [Training Process Progress Chart *APPROXIMATION*](#chart_with_downwards_trend-training-process-progress-chart-approximation)
>* :arrow_right: [Function Output and Neural Network Performance](#arrow_right-function-output-and-neural-network-performance)
>* :no_entry: [SSE, MSE, MAE](#no_entry-sse-mse-mae)
____
## Classification of points :pushpin:
For this task the goal was to create and train a **multilayer perceptron (MLP) neural network** capable of classifying points into **five groups** based on **three parameters *(x, y, z)***. The challenge was to find the **optimal network structure** (the smallest number of neurons in the hidden layer) that would allow the network to correctly classify as many points as possible, with a maximum of **two misclassified points**.

### :page_facing_up: MLP Network Structure *CLASSIFICATION*
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

>:arrow_left: [**Back to *CONTENT***](#content)
### :surfer: Training Parameters *CLASSIFICATION*
```matlab
net.trainParam.goal = 0.001;       % Termination condition for error
net.trainParam.show = 20;          % Frequency of error display
net.trainParam.epochs = 1000;      % Maximum number of epochs
net.trainParam.max_fail = 12;      % Maximum number of failed validations
```

#### *Termination Conditions* *CLASSIFICATION:*
<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/8c62337a-2d97-49ef-b441-43019f146adf" width="200"></td>
    <td>
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

>:arrow_left: [**Back to *CONTENT***](#content)

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

>:arrow_left: [**Back to *CONTENT***](#content)

### :chart_with_downwards_trend: *Training Process Progress Chart* *CLASSIFICATION:*
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

>:arrow_left: [**Back to *CONTENT***](#content)

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

>:arrow_left: [**Back to *CONTENT***](#content)

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

>:arrow_left: [**Back to *CONTENT***](#content)

____
## Approximation of a nonlinear function :pushpin:
For this task the goal was to create and train a **multilayer perceptron (MLP) neural network** capable of approximating a **nonlinear function**. The challenge was to find the **optimal network structure** (the smallest number of neurons in the hidden layer) and set training parameters to achieve **minimal deviation** on test data while ensuring the function output closely matched measured data.

### :page_facing_up: MLP Network Structure *APPROXIMATION*
<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/78ca259b-7cd5-4fb7-bb44-92dc91fce46b" width="200"></td>
    <td>
      <b><i>Input Layer:</i></b>
      <ul>
        <li><b>Number of inputs:</b> 1 neuron representing the independent variable <b>x</b> of the nonlinear function.</li>
        <li><b>Function:</b> Each input point is processed individually by the neural network.</li>
      </ul>
      <b><i>Hidden Layer:</i></b>
      <ul>
        <li><b>Neuron type:</b> Nonlinear neurons with the <i><code>tansig</code> <b>(tangent sigmoid)</b></i> activation function.</li>
        <li><b>Purpose:</b> This function allows modeling nonlinear relationships between inputs and outputs.</li>
        <li><b>Number of neurons:</b> Optimized to <b>25 neurons</b> based on experimentation to ensure accurate function approximation while maintaining minimal deviation.</li>
      </ul>
      <b><i>Output Layer:</i></b>
      <ul>
        <li><b>Neuron type:</b> Linear neurons with the <i><code>purelin</code> <b>(linear)</b></i> activation function.</li>
        <li><b>Purpose:</b> Ensures that outputs are suitable for approximating a continuous function.</li>
        <li><b>Number of neurons:</b> 1 neuron representing the dependent variable <b>y</b>, where <b><i>y = f(x)</i></b>.</li>
      </ul>
    </td>
  </tr>
</table>

>:arrow_left: [**Back to *CONTENT***](#content)

### :repeat: Description of Input and Output Data
#### *INPUT DATA*
*The input variables are loaded from the file `datafun.mat`:*
>```matlab
>data = load("datafun.mat");                % Load data
>x = data.x;                                % Input values
>```
The variable `x` contains values of the **independent variable** of the nonlinear function that the neural network will approximate.

#### *OUTPUT DATA*
*Similarly, the output data is loaded as follows:*
>```matlab
>y = data.y;                                % Output values
>```
The variable `y` contains values of the **dependent variable**, which the network predicts based on the input `x`.

#### *DATA SPLITTING FOR TRAINING AND TESTING*
* *The data is divided using **index-based splitting**, ensuring precise separation of samples:*
>```matlab
>indx_train = data.indx_train;              % Training data indices
>indx_test = data.indx_test;                % Testing data indices
>```
**Training Data:** Indices stored in `indx_train` determine the samples used for network learning.

**Testing Data:** Indices stored in `indx_test` define the samples used for evaluating the network's generalization ability.

* *Assigning Data to Network Indices:*
>```matlab
>net.divideFcn = 'divideind';               % Index-based data splitting
>net.divideParam.trainInd = indx_train;     % Training data
>net.divideParam.testInd = indx_test;       % Testing data
>net.divideParam.valInd = [];               % No validation data
>```
This section of the code explicitly sets which samples will be used for **training** and **testing** the neural network.

>:arrow_left: [**Back to *CONTENT***](#content)

### :surfer: Training Parameters *APPROXIMATION*
| Neural Network Training *10 neurons* | Neural Network Training *25 neurons* | Neural Network Training *50 neurons* |
| ---------------------------------- |:----------------------------------:| ----------------------------------:|
| ![image](https://github.com/user-attachments/assets/0b1d1f6a-8324-4d03-923b-0abc00236e76) | ![image](https://github.com/user-attachments/assets/199c12cd-9040-49e5-8036-3223da03eb79) | ![image](https://github.com/user-attachments/assets/1dafe01a-6fb4-45f3-b8e9-e2fced6d6add) |

#### *Termination Conditions APPROXIMATION:*
* *`net.trainParam.goal = 1e-4;`*
   * **Target error threshold:** Training stops when the error between predicted values and actual outputs falls below **0.0001**.
* *`net.trainParam.epochs = 1000;`*
   * **Maximum number of epochs:** The network can undergo a maximum of **1000 training cycles**.
* *`net.trainParam.show = 5;`*
   * **Error display frequency:** Errors are displayed every **5 epochs** to transparently monitor the training process.

>:paperclip: ***Criterion Function Used:***
> * The **Sum of Squared Errors (SSE)** criterion function is used to evaluate network performance.
> * MATLAB automatically applies **Mean Squared Error (MSE)** as a derived format, which is useful for optimizing weights during training.

>:arrow_left: [**Back to *CONTENT***](#content)

### :chart_with_downwards_trend: *Training Process Progress Chart* *APPROXIMATION:*
![image](https://github.com/user-attachments/assets/d2bd49b6-4400-40e5-ac76-b7e2954eeed7)  
#### POOR LEARNING WITH - 10 Neurons 
> :x: *The network did not learn effectively when the hidden layer contained only **10 neurons**.*
#### :question: *REASONS:*
>* **High Error:** The **Mean Squared Error (MSE)** remained high (**0.5689**), indicating that the network failed to approximate the function correctly.
>* **Maximum Epochs Reached:** The training process completed **1000 epochs**, but the **target error (goal)** was not achieved, suggesting **underfitting**.
>* **Insufficient Capacity:** The number of neurons was too low to capture the **complex relationships** between input and output data.

![image](https://github.com/user-attachments/assets/03e98e61-bf39-4dfe-a6f3-3e24756b69c0) 
#### OPTIMAL LEARNING WITH - 25 Neurons 
> :white_check_mark: *A hidden layer with **25 neurons** achieved the best balance between **accuracy and capacity**.*
#### :100: *RESULTS:*
>* **Training Completion:** The process successfully met the **target error (goal)**, meaning the network correctly approximated the function.
>* **Error Reduction:** The error gradually decreased in each epoch, demonstrating **consistent learning** and **effective weight optimization**.
>* **Final Error:** The error dropped below **1e−4**, confirming strong performance.
>* **Visualization:** The network’s output closely matched the **original data**, proving that **25 neurons** was the ideal number for this task without excessive capacity.

![image](https://github.com/user-attachments/assets/1d0ebd52-e0e4-4524-a747-ba9b80afe356)
#### OVERFITTING RISK WITH - 50 Neurons 
> :x: *A hidden layer with **50 neurons** achieved **high accuracy** on training data but showed **weaker generalization** on test data.*
#### :question: *CONCERNS:*
>* **Overfitting Risk:** The network learned the **training data too well**, potentially capturing **noise** rather than meaningful patterns.
>* **Error Behavior:** The training error was **very low**, but the test error was **slightly higher**, indicating sensitivity to **data noise**.
>* **Output Consistency:** The network’s output remained close to the original data but was **less stable** for test samples, suggesting that an excessive number of neurons might capture **unwanted details**.

>:arrow_left: [**Back to *CONTENT***](#content)

### :arrow_right: *Function Output and Neural Network Performance:*
![image](https://github.com/user-attachments/assets/6a8d9148-e199-4c51-a3ed-f026838bb390)
#### :x: *OUTPUT WITH - 10 Neurons:* 
>* **Description:** The network's output with 10 neurons shows **visible deviations** from the target function. The model fails to accurately capture the relationship between inputs and outputs.
>* **Disadvantages:**
>   * **Limited learning capacity** due to the small number of neurons.
>   * **Underfitting** occurs, leading to **higher error values**.
>* **Conclusion:** **10 neurons is insufficient** for this task, as the network cannot properly approximate the function.

![image](https://github.com/user-attachments/assets/ee66a0e7-ba25-4f4f-b843-a1cc6ebe61eb)
#### :white_check_mark: *OUTPUT WITH - 25 Neurons:* 
>* **Description:** The network's output with **25 neurons** closely follows the shape of the target function (shown in red). This suggests that **25 neurons is the optimal number** for this task.
>* **Advantages:**
>   * The network accurately approximates **complex relationships** between inputs and outputs.
>   * No visible **overfitting** occurs.
>   * The error values (**SSE, MSE**) remain **low** for both training and test data.
>* **Conclusion:** This model provides **strong generalization** and is a suitable solution for the given task.

![image](https://github.com/user-attachments/assets/46606618-336f-4698-8e8c-6535a1888de1)
#### :x: *OUTPUT WITH - 50 Neurons:* 
>* **Description:** The network's output with **50 neurons** closely matches the target function on **training data**, but shows **slight degradation** on **test data**.
>* **Disadvantages:**
>   * A larger number of neurons **increases network capacity**, which can lead to **overfitting**.
>   * The network may learn **noise** from training data, reducing its ability to generalize to new data.
>* **Conclusion:** **50 neurons may be excessive**. While the network achieves **high accuracy** on training data, its performance on test data **declines**, indicating potential overfitting.

>:arrow_left: [**Back to *CONTENT***](#content)

### :no_entry: *SSE, MSE, MAE:*
| Result of Training and Testing with *10 neurons* | Result of Training and Testing with *25 neurons* | Result of Training and Testing with *50 neurons* |
| ---------------------------------- |:----------------------------------:| ----------------------------------:|
| ![image](https://github.com/user-attachments/assets/b578719f-1f71-4978-a273-77a47d819357) | ![image](https://github.com/user-attachments/assets/691c1d36-e263-40ce-a6df-15fa976326ac) | ![image](https://github.com/user-attachments/assets/7bf731d0-1e8d-4d7d-b914-7a095ae05bc3) |
>```matlab
>% Error Calculation
>SSE_train = sse(net, y(indx_train), outnetsim(indx_train));  
>% Sum of Squared Errors (SSE) - Training 
>MSE_train = mse(net, y(indx_train), outnetsim(indx_train));  
>% Mean Squared Error (MSE) - Training 
>MAE_train = mae(net, y(indx_train), outnetsim(indx_train));  
>% Mean Absolute Error (MAE) - Training 
>% Visualization of results  
>fprintf("---- Training Results -----\n"); 
>fprintf("SSE: %d\n", SSE_train); 
>fprintf("MSE: %d\n", MSE_train); 
>fprintf("MAE: %d\n", MAE_train); 
>fprintf("-----------------\n"); 
>SSE_test = sse(net, y(indx_test), outnetsim(indx_test));     
>% Sum of Squared Errors (SSE) - Testing 
>MSE_test = mse(net, y(indx_test), outnetsim(indx_test));     
>% Mean Squared Error (MSE) - Testing 
>MAE_test = mae(net, y(indx_test), outnetsim(indx_test));     
>% Mean Absolute Error (MAE) - Testing 
>fprintf("---- Testing Results -----\n"); 
>fprintf("SSE: %d\n", SSE_test); 
>fprintf("MSE: %d\n", MSE_test); 
>fprintf("MAE: %d\n", MAE_test); 
>fprintf("-----------------\n");
>```

>:heavy_exclamation_mark: *On the **screenshots of the results**, the **training and testing** results are written in **Slovak**.*
>* The **upper section** of the screenshot contains the **training results**.
>* The **lower section** displays the **testing results**.
>In the **published code**, these labels have already been **translated into English**.

>:arrow_left: [**Back to *CONTENT***](#content)
