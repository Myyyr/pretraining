#!/bin/bash
#SBATCH --job-name=naglamsegformer     # job name
#SBATCH --ntasks=8                  # number of MP tasks
#SBATCH --ntasks-per-node=4          # number of MPI tasks per node
#SBATCH --gres=gpu:4                 # number of GPUs per node
#SBATCH --cpus-per-task=10           # number of cores per tasks
#SBATCH --hint=nomultithread         # we get physical cores not logical
#SBATCH --time=00:05:59              # maximum execution time (HH:MM:SS)
#SBATCH --qos=qos_gpu-dev
#SBATCH --output=logs/naglamsegformer%j.out # output file name
#SBATCH --error=logs/naglamsegformer%j.err  # error file name


# # #   SBATCH -C v100-32g

set -x


cd $WORK/pretraining
module purge
module load cuda/10.1.2
module load python/3.7.10


DATA="/gpfsscratch/rech/arf/unm89rb/imagenet"
# CONFIG="configs/swin_tiny_patch4_window7_224.yaml"
CONFIG="configs/glam_segformer_patch4_window7_224.yaml"


# swin
# srun /gpfslocalsup/pub/idrtools/bind_gpu.sh python -u  main.py --cfg $CONFIG --data-path $DATA --batch-size 128 --local_rank 0 $1 $2
# srun /gpfslocalsup/pub/idrtools/bind_gpu.sh python -u  main.py --cfg $CONFIG --data-path $DATA --batch-size 32 --local_rank 0 --accumulation-steps 4 $1 $2
srun /gpfslocalsup/pub/idrtools/bind_gpu.sh python -u  main.py --cfg $CONFIG --data-path $DATA --batch-size 32 --local_rank 0 --accumulation-steps 4 $1 $2 --amp-opt-level 00
# srun /gpfslocalsup/pub/idrtools/bind_gpu.sh python -u  main.py --cfg $CONFIG --data-path $DATA --batch-size 64 --local_rank 0 --accumulation-steps 2 --use-checkpoint $1 $2

