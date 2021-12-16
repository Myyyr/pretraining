#!/bin/bash

# get_last () {
#     folder="files"
#     let last=0
#     for f in "$folder"/*
#     do
#         ext=${f##*.}
#         if [ "$ext" = "pth" ]; then
#             tmp=${f%.*}
#             tmp=${tmp##*_}
#             if [[ $tmp > $last ]]; then
#                 let last=tmp
#             fi
#         fi
#     done
#     echo $last
# }
# ret="$(get_last)"
# echo "Last: $ret"


# jid=$(sbatch slurm.sh | cut -d ' ' -f4)
# echo "jid: $jid"


# sbatch $1

end=`expr $2 - 1`
for k in `seq 1 $end`;
    do temp="${k}"
        # jid=$(sbatch --dependency=afterok:${jid} slurm_resume.sh ${k} | cut -d ' ' -f4)
        # jid=$(sbatch --dependency=singleton slurm.sh --resume | cut -d ' ' -f4)
        sbatch --dependency=singleton $1 --resume auto
    done