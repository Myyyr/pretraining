#!/bin/bash
#SBATCH --job-name=pretswin     # job name
#SBATCH --ntasks=8                  # number of MP tasks
#SBATCH --ntasks-per-node=4          # number of MPI tasks per node
#SBATCH --gres=gpu:4                 # number of GPUs per node
#SBATCH --cpus-per-task=10           # number of cores per tasks
#SBATCH --hint=nomultithread         # we get physical cores not logical
#SBATCH --time=00:04:59              # maximum execution time (HH:MM:SS)
#SBATCH --qos=qos_gpu-dev
#SBATCH --output=logs/pretswin%j.out # output file name
#SBATCH --error=logs/pretswin%j.err  # error file name

set -x


cd $WORK/transseg2d
module purge
module load cuda/10.1.2
module load python/3.7.10


DATA="data/imagenet"
CONFIG="configs/swin_tiny_patch4_window7_224.yaml"



# swin
srun /gpfslocalsup/pub/idrtools/bind_gpu.sh python -u -m torch.distributed.launch --nproc_per_node 8 --master_port 12345  main.py --cfg $CONFIG --data-path $DATA --batch-size 128
# srun /gpfslocalsup/pub/idrtools/bind_gpu.sh python -u tools/train.py $CONFIG --options model.pretrained=$PRET --launcher="slurm" --seed 0 --deterministic ${@:3}
# srun /gpfslocalsup/pub/idrtools/bind_gpu.sh python -u tools/train.py $CONFIG --resume-from=$RESUME --launcher="slurm" ${@:3} --seed 0 --deterministic ${@:3}