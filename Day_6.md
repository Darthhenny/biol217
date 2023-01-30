# Pangenomics - comparing genomes
Files were created for us in Day6: 02_contigs-dbs (enthält contigs) & 03_pangenome
```
ssh -X sunam236@caucluster-old.rz.uni-kiel.de
cd /work_beegfs/sunam236/Day6/
```

## 1. Recap on batch script

## 2. Evaluating the contigs database
get direct access to a HPC compute node
```
srun --reservation=biol217 --pty --mem=10G --nodes=1 --tasks-per-node=1 --cpus-per-task=1 /bin/bash
```
Node=010

activate the conda environment
```
conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
```
start anvi'o interactive display
```
cd /02_contigs-dbs/
anvi-display-contigs-stats *db
```
new terminal
```
ssh -L 8060:localhost:8080 sunam236@caucluster-old.rz.uni-kiel.de
ssh -L 8080:localhost:8080 node010
```

## 3.Create pangenome from individual bins/genomes
create a external genome file
```
cd /03_pangenome/
anvi-script-gen-genomes-file --input-dir ../02_contigs-dbs/ -o external_genomes.txt
```
Etsimate genome completeness
```
anvi-estimate-genome-completeness -e external_genomes.txt -o ./genome-completeness.txt
```
remove all copletion < 75%, redundancy >10
Just remove the contigs.db from the folder
--> Methano_Bin10 + 5
```
cd ../02_contigs-dbs/
mkdir discarded
mv Bin10.db Bin5.db  ./discarded/
```
Create a new extenral-genomse output, for the updated bins
```
cd ../03_pangenome/
anvi-script-gen-genomes-file --input-dir ../02_contigs-dbs/ -o external_genomes_final.txt
```

Create Pangenome database
create script: script_pangenome.sh
```
#SBATCH --mem=500M
#SBATCH --time=0:05:00
#SBATCH --job-name=pangenome
#SBATCH --output=pangenome.out
#SBATCH --error=pangenome.out
#SBATCH --partition=all
#SBATCH --reservation=biol217

#load and activate anvio environment
module load miniconda3/4.7.12.1
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
# Command
cd /work_beegfs/sunam236/Day6/03_pangenome/

anvi-gen-genomes-storage -e external_genomes_final.txt -o genomes_storage-GENOMES.db

anvi-pan-genome -g genomes_storage-GENOMES.db --project-name pangenome --num-threads 10
#this prints the required resources into your logfile
jobinfo
```
```
sbatch script_pangenome.sh 
```

## 4. Compare the data phylogenetically (ANI)
create script: script_panANI.sh
```
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=600M
#SBATCH --time=0:02:00
#SBATCH --job-name=pangenome
#SBATCH --output=pangenome.out
#SBATCH --error=pangenome.out
#SBATCH --partition=all
#SBATCH --reservation=biol217

#load and activate anvio environment
module load miniconda3/4.7.12.1
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
# Command
cd /work_beegfs/sunam236/Day6/03_pangenome/

anvi-compute-genome-similarity --external-genomes external_genomes_final.txt --program pyANI --output-dir ./ANI --num-threads 10 --pan-db ./pangenome/Pangenome-PAN.db
#this prints the required resources into your logfile
jobinfo
```
```
sbatch script_panANI.sh 
```
## 5. Visualise the pangenome
```
srun --pty --mem=10G --nodes=1 --tasks-per-node=1 --cpus-per-task=1 --reservation=biol217 --partition=all /bin/bash
```
activate the conda environment
```
conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
```
```
anvi-display-pan -p ./pangenome/Pangenome-PAN.db -g ./genomes_storage-GENOMES.db -P 8080
```
## 6. Interprete and order the pangenome

## 7. Blast Koala (Bonus)