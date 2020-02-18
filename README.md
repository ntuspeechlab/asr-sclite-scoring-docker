# asr-sclite-scoring-docker


## Project Description
This project is supposed to use Sclite utilities from SCTK (https://github.com/usnistgov/SCTK) to score speech recognition system output. Please refer to http://www1.icsi.berkeley.edu/Speech/docs/sctk-1.2/options.htm for commandline options usage.


## Usage

Command to build the image

      docker build -t speechlab.azurecr.io/sclite-scoring-debian:1.0 -f Dockerfile_sclite_debian . 

Command to use (get the docker-compose file in test/ folder)
      
      docker-compose -f docker-compose_sclite.yml up


## Testing
To test this docker image, you should prepare the reference and hypotheses. Requirements for reference format and hypotheses are descibed below.
While scoring the speech recognition system output in plain text format, we adding the dummy speaker id, in format of (speaker_<digits>).
After scoring, this place holder will be removed, however, the owner of the file become root (Need to fix this issue!)

You can follow the output in test/output/ folder for more details.

To choose between the time-boundary format vs plain-text format, you can pass the parameter in docker-compose file:

    command: /workspace/score.sh "text" # If you want to score in plain-text format
    command: /workspace/score.sh        # If you want to score with time boundary format


### References
Reference file can be in STM or plain text format. Please checking the sample files in test/ref/ folder for more details. 

### Hypotheses
Reference file can be in CTM or plain text format. Please checking the sample files in test/hyp/ folder for more details.


## Changes
  - February 18, 2020: Fix bugs while scoring in plain-text format
  - February 17, 2020: Initial version
 


