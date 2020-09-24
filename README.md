# AcasXu


### Requirements

- MATLAB (>2017b)

- [NNV](https://github.com/verivital/nnv) and its dependencies

- Simulink (>9.0)

- Stateflow

The last 2 are only needed in order to execute [Simulink models](https://github.com/dieman95/AcasXu/tree/master/simulation). 

### Prepare 

Before executing any code, please install [NNV](https://github.com/verivital/nnv), instructions can be found [here](https://github.com/verivital/nnv/blob/master/README.md). 

Run [startup_nnv.m](https://github.com/verivital/nnv/blob/master/code/nnv/startup_nnv.m) before running any files.

Copy all the files under the [utils](https://github.com/dieman95/AcasXu/tree/master/utils) folder, and copy into the your MATLAB root folder under the specific toolbox. An example: */usr/local/MATLAB/R2018b/toolbox/nnet/nnet/nntransfer* .

### Repository Overview

- **Properties**: contains descriptions of 10 open-loop safety properties to verify.

- **main**: core of this work. Contains the core reachability and simulation scripts, as well as all the functions to run them.

- **other**: contains multiple reachability, simulation and miscellanious code to test the ACAS Xu NNCS.

- **networks**: all 45 AcasXu NNs in ONNX, nnet and NNV format and as Simulink blocks.

- **simulation**: Simulink models of the AcasXu closedloop system.

- **utils**: extra functions and required scripts to run certain simulation scripts (not needed for main code).

### Contact

Please, feel free to contact Diego Manzanas for any questions

 -  diego DOT manzanas DOT lopez AT vanderbilt DOT edu
