#!/bin/bash


jid=$(sbatch slurm.sh | cut -d ' ' -f4)


for k in {0..3};
    do temp="${k}"
        jid=$(sbatch --dependency=afterok:${jid} slurm_resume.sh ${k} | cut -d ' ' -f4)
    done