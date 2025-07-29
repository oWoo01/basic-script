#!/bin/bash

x_Cu=($(seq 0.10 0.05 0.35))
seed=(61318 12532 84113 51347 98421)
for i in ${!x_Cu[@]}; do
	prop0=${x_Cu[$i]}
	for j in ${!seed[@]}; do
		random0=${seed[$j]}
		jobname=${prop0}-${random0}
        	squeue > now_job.squeue
		tot_num=$(wc -l now_job.squeue | cut -d ' ' -f 1)
		while [[ tot_num -gt 1 ]]; do
			echo "Waiting:$tot_num jobs in the squeue..."
			sleep 10
			echo "Waiting for the jobs to finish"
			squeue > now_job.squeue
			tot_num=$(wc -l now_job.squeue | cut -d ' ' -f 1)
		done
		echo "${jobname}"
		cat > tj.sh <<EOF
#!/bin/bash
#SBATCH -J ${jobname}
#SBATCH -N 1
#SBATCH -p xahcnormal
#SBATCH --ntasks-per-node=32
#SBATCH --cpus-per-task=1
#SBATCH -o ${jobname}.out

ulimit -s unlimited
ulimit -l unlimited

module purge
source /work/home/jyzhang/apprepo/lammps/stable.29Aug2024-intelmpi2021/scripts/env.sh
export UCX_IB_ADDR_TYPE=ib_global
export I_MPI_PMI_LIBRARY=/opt/gridview/slurm/lib/libpmi.so

srun --mpi=pmix_v3 lmp_mpi -var prop ${prop0} -var r ${random0} -in in.elastic


EOF
	sbatch tj.sh
	done	
done
