#!/bin/bash
#
#SBATCH --partition=serial
#SBATCH --qos=serial
#SBATCH --nodes=1 
#SBATCH --mem=8G 
#SBATCH --tasks-per-node=2
#SBATCH --cpus-per-task=1
#SBATCH --time=23:50:00
#SBATCH --job-name=ECCver
#SBATCH --account=ecseab06-guest

# Jobs not charged but requires at least 1 CU in budget to use. Maximum of 32 cores and/or 128 GB in use by any one user at any time.
# https://docs.archer2.ac.uk/user-guide/scheduler/#quality-of-service-qos

# trying 2 mpi default for verification with mpi


module load  PrgEnv-cray

module load cray-hdf5-parallel
module load cray-netcdf-hdf5parallel


export LD_LIBRARY_PATH=$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH

export MITGCM_ROOTDIR=/work/n02/shared/mjmn02/ECCOv4/MITgcm

export MOPTF=$PWD/dev_linux_amd64_cray_archer2

cd /work/n02/shared/mjmn02/ECCOv4/MITgcm/verification
export OMP_NUM_THREADS=1

./testreport -mpi --optfile=$MOPTF -c 'srun --hint=nomultithread mitgcmuv' -j 2


