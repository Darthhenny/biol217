# Day_4 anvio
*`continue of day 3`*
## connect to shh-old
```
ssh -X sunam236@caucluster-old.rz.uni-kiel.de
```
## New conda environment
```
conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
```
------------------------------------
```
anvi-cluster-contigs -h
anvi-self-test --suite mini
```
create script: script_anvio.sh
```
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=avio
#SBATCH --output=anvio.out
#SBATCH --error=anvio.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

#load and activate anvio environment
module load miniconda3/4.7.12.1
conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
#anvio
anvi-gen-contigs-database -f ./4_mapping/contigs.anvio.fa -o ./5_anvio_profiles/contigs.db -n 'biol217'
#this prints the required resources into your logfile
jobinfo
```
run script
```
cd /work_beegfs/sunam236/day3/
sbatch script_anvio.sh
squeue -u sunam236
```
for HMM
create script: script_anvio_2.sh
```
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=avio
#SBATCH --output=anvio.out
#SBATCH --error=anvio.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

#load and activate anvio environment
module load miniconda3/4.7.12.1
conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
#anvio
anvi-run-hmms -c ./5_anvio_profiles/contigs.db 
#this prints the required resources into your logfile
jobinfo
```
run script
```
sbatch script_anvio.sh
squeue -u sunam236
```

## Anvi-display-contigs-stat

access anvi'o interactiv
`use every time you want to visualize`

```
srun --pty --mem=10G --nodes=1 --tasks-per-node=1 --cpus-per-task=1 --partition=all /bin/bash
```
- node077

next 
```
conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1

anvi-display-contigs-stats contigs.db
```
`open new terminal`

```
ssh -L 8060:localhost:8080 sunam236caucluster-old.rz.uni-kiel.de
ssh -L 8080:localhost:8080 node077
```
Server address ...............................: http://0.0.0.0:8080

`open google chrome and paste`
http://127.0.0.1:8060 or http://127.0.0.1:8080

## Binning with anvio
### Sort and index
create a new script:script_anvio_4_binning.sh
```
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=anvio_binning
#SBATCH --output=anvio_binning.out
#SBATCH --error=anvio_binning.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

cd ./4_mapping/
#load and activate anvio environment
module load miniconda3/4.7.12.1
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
#anvio
for i in *.bam; do anvi-init-bam $i -o ../5_anvio_profiles/"$i".sorted.bam; done
#this prints the required resources into your logfile
jobinfo
```
Run script
```
sbatch script_anvio_4_binning.sh
squeue -u sunam236
```
### Creating an avio profile
create a new script:script_anvio_5
```
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=anvio_5
#SBATCH --output=anvio_5.out
#SBATCH --error=anvio_5.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

cd ./5_anvio_profiles
#load and activate anvio environment
module load miniconda3/4.7.12.1
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
#anvio
for i in `ls *.sorted.bam | cut -d "." -f 1`; do anvi-profile -i "$i".fastq.gz.sam.bam.sorted.bam -c contigs.db -o ../6_profiling/$i; done
#this prints the required resources into your logfile
jobinfo
```
Run script
```
sbatch script_anvio_5.sh
squeue -u sunam236
```
-------------------------
anvimerge
create a new script:script_anvio_6
```
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=anvio_6
#SBATCH --output=anvio_6.out
#SBATCH --error=anvio_6.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

cd ./6_profiling/
#load and activate anvio environment
module load miniconda3/4.7.12.1
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
#anvio
anvi-merge ./BGR_130305_mapped_R1/PROFILE.db ./BGR_130527_mapped_R1/PROFILE.db ./BGR_130708_mapped_R1/PROFILE.db -o ./ -c ../5_anvio_profiles/contigs.db --enforce-hierarchical-clustering
#this prints the required resources into your logfile
jobinfo
```
Run script
```
sbatch script_anvio_6.sh
squeue -u sunam236
```
------------------------------------------------------
`*from here it didnt work at all, so we copied the final file*`
### metabat2
create a new script:script_smetabat2.sh
```
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=metabat2
#SBATCH --output=metabat2.out
#SBATCH --error=metabat2.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

cd ./6_profiling/
#load and activate anvio environment
module load miniconda3/4.7.12.1
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
#anvio
anvi-merge ./BGR_130305_mapped_R1/PROFILE.db ./BGR_130527_mapped_R1/PROFILE.db ./BGR_130708_mapped_R1/PROFILE.db -o ./ -c ../5_anvio_profiles/contigs.db --enforce-hierarchical-clustering
#this prints the required resources into your logfile
jobinfo
```
Run script
```
sbatch script_metabat2.sh
squeue -u sunam236
```

# Mags quality estimation
`skipped steps to get to here`

See the amoubt of bins 
```
module load miniconda3/4.7.12.1
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1

anvi-estimate-genome-completeness -p PROFILE.db -c contigs.db --list-collection
```



visualize
```
srun --pty --mem=10G --nodes=1 --tasks-per-node=1 --cpus-per-task=1 --partition=all /bin/bash
```
node013
```
module load miniconda3/4.7.12.1
source activate /home/sunam225/miniconda3/miconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
cd
anvi-interactive -p ./PROFILE.db -c ./contigs.db -C ../../consolidated_bins
```


*`still not finished with day 3 script`*