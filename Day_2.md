# Day2 Quality check the sequences

## acces HPC-server
```
~$ ssh -X sunam236@caucluster.rz.uni-kiel.de
```

## copy testscript to personal home 
```
cp anviscript /home/sunam236/
```
Script eddited and saved as script_day2

## Copy the fastas to work
```
cd /work_beegfs/sunam236/

mkdir day2
ls
cp /home/sunam226/Day2/0_raw_reads/*.fastq.gz /work_beegfs/sunam236/day2
cd day2
ls
pwd
```
copy the script to this file

```
cp script_day2 /work_beegfs/sunam236/day2
```
# see the quality via fastqc

## load and activate anvio environment
```
module load miniconda3/4.7.12.1

conda activate /home/sunam236/.conda/envs/anvio

module load fastqc
```
## run fastqc in a loop for all .gz files
```
for i in *.gz; do fastqc $i -o output_folder/; done
```
## do it over the HPC (with the changed anvio testscript)

Create a script: script_day2
```
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=fastqc
#SBATCH --output=fastqc.out
#SBATCH --error=fastqc.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

#load and activate anvio environment
module load miniconda3/4.7.12.1

conda activate /home/sunam236/.conda/envs/anvio

#fastqc 

#this prints the required resources into your logfile
jobinfo
```

```
sbatch script_day2

squeue -u sunam236
```
## Cut the sequences (from Virus, according to phred,...)
see what we can do
```
fastp --h
```
Create a script: script_day2_cut . Cut sequences in a loop 
```
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=fastp
#SBATCH --output=fastp.out
#SBATCH --error=fastp.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

module load miniconda3/4.7.12.1
conda activate /home/sunam226/.conda/env/anvio

#cut the sequences
for i in `ls *_R1.fastq.gz`;
do
    second=`echo ${i} | sed 's/_R1/_R2/g'`
    fastp -i ${i} -I ${second} -R _report -o ../clean_reads/"${i}" -O ../clean_reads/"${second}" -t 6 -q 20

done
```

```
sbatch script_day2_cut

squeue -u sunam236
```

#Run megahit to assemble

create a script: script_day2_assembly
```
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=megahit
#SBATCH --output=megahit.out
#SBATCH --error=megahit.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

cd /work_beegfs/sunam236/day2/clean_reads

#load and activate anvio environment
module load miniconda3/4.7.12.1
source activate /home/sunam226/.conda/envs/anvio
#conda activate /home/sunam226/.conda/envs/anvio
#Megahit             
megahit -1 BGR_130305_R1.fastq.gz -1 BGR_130527_R1.fastq.gz -1 BGR_130708_R1.fastq.gz -2 BGR_130305_R2.fastq.gz -2 BGR_130527_R1.fastq.gz -2 BGR_130708_R2.fastq.gz --min-contig-len 1000 --presets meta-large -m 0.85 -o ../megahit -t 20   
#this prints the required resources into your logfile
jobinfo                
```
```
sbatch script_day2_assembly
```