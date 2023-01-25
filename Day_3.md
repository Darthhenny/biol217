# 3_Binning

## acces HPC-server (old one because they set up a new one) 
```
~$ ssh -X sunam236@caucluster-old.rz.uni-kiel.de
```
Create new folders for today
```
cd /work_beegfs/sunam236/
mkdir 2_fastp 3_coassembly 3_metaquast 4_mapping 5_anvio_profile
```
copy the data from teachers server
```
cp -r /home/sunam226/Day3/* /work_beegfs/sunam236/day3
```
--------------------------------------------
## Bandage to see the binned contigs
```
conda activate /home/sunam226/.conda/envs/anvio
```
```
less final.contigs.fa
```
see how many sequences we got
```
grep -c ">" final.contigs.fa
```

Transform fasta into fastg for Bandage
```
cd /day3/3_coassembly/
megahit_toolkit contig2fastg 99 final.contigs.fa > final.contigs.fastg  
```
copy fastg file to desktop

In *new terminal* enter bandage
```
cd Desktop/Bandage/
./Bandage
```
--------------------------------
```
cp ../../day2/script_day2
```
run the script 
```
!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=metaquast
#SBATCH --output=metaquast.out
#SBATCH --error=metaquast.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

#load and activate anvio environment
module load miniconda3/4.7.12.1
source activate /home/sunam236/.conda/envs/anvio
#metaquast
cd /work_beegfs/sunam236/3_coassembly/
metaquast -t 6 -o ../3_metaquast/ -m 1000 final.contigs.fa
#this prints the required resources into your logfile
jobinfo
```
*does not work* so copying the output
```
cp -r /home/sunam226/Day3/3_metaquast_out /work_beegfs/sunam236/day3/
```