# Multilayer Perceptron Network
Example of two simple multilayer perceptron networks written in MATLAB.
The purpose of the task was to create a **multilayer perceptron (MLP) neural network** for **[classification](#classification-of-points) and approximation**.

## Classification of points
For this task the goal was to create and train a **multilayer perceptron (MLP) neural network** capable of classifying points into **five groups** based on **three parameters *(x, y, z)***. The challenge was to find the **optimal network structure** (the smallest number of neurons in the hidden layer) that would allow the network to correctly classify as many points as possible, with a maximum of **two misclassified points**.

### MLP Network Structure
<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/1b7756b6-89fe-4a46-8088-be122edffc2a" width="200"></td>
    <td>
      <b>Input Layer:</b>
      <ul>
        <li><b>Number of inputs:</b> 3 inputs neurons representing the coordinates <i>x, y, z</i>.</li>
        <li><b>Function:</b> Receives input data from the file <i>databody.mat</i>.</li>
      </ul>
      
      <b>Hidden Layer:</b>
      <ul>
        <li><b>Number of neurons:</b> Optimized to <b>10 neurons</b> to minimize classification error.</li>
        <li><b>Neuron type:</b> Uses the <b>logsig (log-sigmoid)</b> activation function, transforming inputs for calculations in the output layer.</li>
      </ul>
      
      <b>Output Layer:</b>
      <ul>
        <li><b>Number of outputs:</b> 5 neurons, each representing a distinct group of points.</li>
        <li><b>Neuron type:</b> Uses the <b>softmax</b> activation function, ensuring probabilistic output for classification.</li>
      </ul>
    </td>
  </tr>
</table>

### Training Parameters
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
