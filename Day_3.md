# 3_Binning

## acces HPC-server (old one because they set up a new one) 
```
ssh -X sunam236@caucluster-old.rz.uni-kiel.de
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
run the script: script_metaquast.sh 
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
----------------------------------
# Binning
changing name
```
anvi-script-reformat-fasta final.contigs.fa -o /work_beegfs/sunam236/day3/contigs.anvio.fa --min-len 1000 --simplify-names --report-file name_conversion.txt
```

Change script to: binning_script
```#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=binning
#SBATCH --output=binning.out
#SBATCH --error=binning.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

#load and activate anvio environment
module load miniconda3/4.7.12.1
conda activate /home/sunam236/.conda/envs/anvio
#Binning
anvi-script-reformat-fasta final.contigs.fa -o /work_beegfs/sunam236/day3/contigs.anvio.fa --min-len 1000 --simplify-names--report-file name_conversion.txt
#this prints the required resources into your logfile
jobinfo
```
*not working, due to conda error. so copied final file from teacher*
----------------------
# mapping
create a new script: mapping.sh
```#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=mapping
#SBATCH --output=mapping.out
#SBATCH --error=mapping.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

#load and activate anvio environment
module load miniconda3/4.7.12.1
source activate /home/sunam236/.conda/envs/anvio
#mapping_2
bowtie2-build /work_beegfs/sunam236/day3/4_mapping/contigs.anvio.fa /work_beegfs/sunam236/day3/4_mapping/contigs.anvio.fa.index
#this prints the required resources into your logfile
jobinfo
```
create a new scrip: mapping_s.sh <br> 
takes a long time 
```
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=mapping_2
#SBATCH --output=mapping_2.out
#SBATCH --error=mapping_2.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

#load and activate anvio environment
module load miniconda3/4.7.12.1
source activate /home/sunam236/.conda/envs/anvio
#mapping_2
cd ./2_fastp/
for i in  `ls *mapped_R1.fastq.gz`;
do
    second=`echo ${i} | sed 's/_R1/_R2/g'`
    bowtie2 --very-fast -x ../4_mapping/contigs.anvio.fa.index -1 ${i} -2 ${second} -S ../4_mapping/"$i".sam 
done
#this prints the required resources into your logfile
jobinfo
```
-----------------------------------
# sam tools
create a new script: sam.sh
```#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=sam
#SBATCH --output=sam.out
#SBATCH --error=sam.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

#load and activate anvio environment
module load miniconda3/4.7.12.1
source activate /home/sunam236/.conda/envs/anvio
module load samtools
#mapping_2
cd ./4_mapping/
for i in *.sam; do samtools view -bS $i > "$i".bam; done
#this prints the required resources into your logfile
jobinfo
```
*Did not finish, so anvio will be done tomorrow*


