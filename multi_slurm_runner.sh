#!/bin/bash


jid=$(sbatch slurm.sh | cut -d ' ' -f4)
echo "jid: $jid"

for k in {0..1};
    do temp="${k}"
        # jid=$(sbatch --dependency=afterok:${jid} slurm_resume.sh ${k} | cut -d ' ' -f4)
        jid=$(sbatch --dependency=singleton slurm_resume.sh ${k} | cut -d ' ' -f4)
    	echo "jid: $jid"
    done