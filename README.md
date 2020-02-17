# asr-sclite-scoring-docker


## Project Description
This project is supposed to use Sclite utilities from SCTK (https://github.com/usnistgov/SCTK) to score speech recognition system output. Please refer to http://www1.icsi.berkeley.edu/Speech/docs/sctk-1.2/options.htm for commandline options usage.


## Usage

Command to build the image

      docker build -t speechlab.azurecr.io/sclite-scoring-debian:1.0 -f Dockerfile_sclite_debian . 

Command to use (get the docker-compose file in test/ folder)
      
      docker-compose -f docker-compose_sclite.yml up


## Testing
To test this docker image, you should prepare the reference and hypotheses. Requirements for reference format and hypotheses are descibed below

### References

### Hypotheses


## Changes
  - February 17, 2020: Initial version
 


