# AcasXu

### Prepare 

Before executing any code, please install [NNV](https://github.com/verivital/nnv), instructions can be found [here](https://github.com/verivital/nnv/blob/master/README.md). 

Run [startup_nnv.m](https://github.com/verivital/nnv/blob/master/code/nnv/startup_nnv.m) before running any files.

Copy all the files under the [utils](https://github.com/dieman95/AcasXu/tree/master/utils) folder, and copy into the your MATLAB root folder under the specific toolbox. An example of this is, in my case: */usr/local/MATLAB/R2018b/toolbox/nnet/nnet/nntransfer* .

### Requirements

- MATLAB

- Deep Learning Toolbox

- Simulink (>9.0)

- Stateflow

- MATLAB (2017b)

The last 3 are only needed in order to execute the [Simulink models](https://github.com/dieman95/AcasXu/tree/master/simulation). 

### Repository Overview

- **Properties**: contains descriptions of 10 safety properties to verify.

- **code**: core of this work. Contains testing, simulation (MATLAB), and NN generation files.

- **networks**: all 45 AcasXu NNs in NNV format and as Simulink blocks.

- **simulation**: Simulink models of the AcasXu closedloop system.

- **utils**: extra functions and required scripts.

### Contact

Please, feel free to contact Diego Manzanas for any questions

 -  diego DOT manzanas DOT lopez AT vanderbilt DOT edu
