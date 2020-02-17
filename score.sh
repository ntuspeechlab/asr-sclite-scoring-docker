#!/bin/bash

source $HOME/.bashrc


display_usage() {
	echo -e "\n[Err] Incorrect input parameters."
	echo -e "\nUsage: ./score.sh [arguments] [ouput-dir] [optional-arguments]\n"
	echo -e "[arguments]"
	echo -e "-refDir reference-dir \t\t Input directory contains ground-truth transcription"
	echo -e "-hypDir hypothesis-dir \t\t Input directory contains hypothesis transcription (output of ASR engines)"
	echo -e "[output-dir]"
	echo -e "-opt options \t\t Option for output (for example: text) \n"
	echo -e "path/to/outputdir	\t the scoring results will be saved into this directory (No backslash at the path)\n"
	echo -e "[optional-arguments] Reserved.\n"
	}


refDir=/workspace/ref
hypDir=/workspace/hyp
outDir=/workspace/output
logDir=/workspace/logs

notimefmt="text"
scorefmt="stm"

if [[ $# -eq 1 ]]; then
    echo "Number of parameters $#"
    scorefmt=$1
    echo "Selected format: $scorefmt"
fi

echo "----------------------------------------------"
echo "NIST Speech Recognition Scoring Toolkit (SCTK)"
echo "--- Scoring the reference vs hypothesis ---"
echo "Reference directory: $refDir"
echo "Hypothesis directory: $hypDir"
echo "Output directory: $outDir"
echo ""

if [ "$scorefmt" = "$notimefmt" ]; then
	echo "Scoring with plain-text format"
	for file in $refDir/*.txt
	do
		for ((i = 0; i < 1; i++))
		do
			name=${file##*/}
			base=${name%.txt}
			ref_txt=$refDir/"${base}".txt
			hyp_txt=$hypDir/"${base}".txt
			echo "# LOG (Info): Scoring speech to text between hypothesis $hyp_txt against reference $ref_txt. "
			
			if [ ! -f "$hyp_txt" ]; then
				echo "# LOG (Error): Expected hypothesis file $hyp_txt not found! Cannot run scoring for file id $base" 2>&1 | tee -a $logDir/$base.txt
				continue
			fi
			
			sclite -r $ref_txt -h $hyp_txt -i rm -o dtl prf >> $logDir/$base.txt
			
			mv $hypDir/"${base}".ctm.prf $outDir/
			mv $hypDir/"${base}".ctm.dtl $outDir/
		done
	done
	
else
	echo "Scoring with time-boundary format"
	for file in $refDir/*.stm
	do
		for ((i = 0; i < 1; i++))
		do
			name=${file##*/}
			base=${name%.stm}
			ref_stm=$refDir/"${base}".stm
			hyp_ctm=$hypDir/"${base}".ctm
			echo "# LOG (Info): Scoring speech to text between hypothesis $hyp_ctm against reference $ref_stm. "
			
			if [ ! -f "$hyp_ctm" ]; then
				echo "# LOG (Error): Expected hypothesis file $hyp_ctm not found! Cannot run scoring for file id $base" 2>&1 | tee -a $logDir/$base.txt
				continue
			fi
			
			sclite -r $ref_stm stm -h $hyp_ctm ctm -o dtl prf >> $logDir/$base.txt
			mv $hypDir/"${base}".ctm.prf $outDir/
			mv $hypDir/"${base}".ctm.dtl $outDir/
		done
	done
fi


