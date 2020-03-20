# Code

After following the instructions to setup the repository in the main [README](https://github.com/dieman95/AcasXu/blob/master/README.md)
simply add the functions folder to your MATLAB path, either using relative or full path

``` addpath('functions');```

Then, you will be able to run any file in this repository.

All the files and functions in this folder will be targeted to the the simulation and verification of the AcasXu closedloop 
system under the following assumptions. We use a 2-dimensional Dubins model for the aircrafts that maintain a constant velocity and a 
constant height. Therefore, we are able to set time until loss of separation to 0 (_t_=0), so we only need to consider 5 NNs in the 
control system.

The _functions_ folder includes dynamics, conversion and helper functions that help run the scripts in this repo. 

The _nn_new_ folder contains all the newly created neural networks used for the verification approaches.

#### Simulation files

 - _Simulate_batch_m_1_ : Simulates multiple specified closed-loop scenarios of the original setup as well as some random 
ones. It calls the Simulink _batch_ model and returns all simulated data as well as the trajectory plot from each simulation.

 - _CompareSimulations_ : Compares a closedloop simulation trajectory from all different aproaches. 
It returns a plot with all the ownship trajectories.

#### Test files
 
 - _Test_simpleAcasxu1_ : Test the simple_acasxu1 NN wrt the 5 original networks. It includes random open-loop 
 simulations as well as reachability analysis comparisons.
 
 - _Test_switchAcasxu1_ : Test the switch NN system wrt the 5 original networks. It includes random open-loop simulations.

#### Create NN files

 - _convert_all_ : convert all 45 AcasXu NNs into Simulink blocks
 
 - _switch_acasxu1_ : create a NN to substitute the if-statement to choose one of the possible 5 NNs corresponding to _t_=0.
 
 - _simple_acasxu1_ : create an equivalent NN to all 5 Acasxu NN (_t_=0) executing in parallel (sanity check)
 
 - _afterswitch_acasxu1_ : create a NN that takes 10 inputs, 5 original inputs + 5 outputs from the switch\_acasxu to compute 
the equivalent advisory as using the original system with if-loop with 5 NNs.
