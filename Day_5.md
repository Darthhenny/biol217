# Day_5
*`continue of day 3`*

## MAGs quality estimation
See the amoubt of bins 
```
module load miniconda3/4.7.12.1
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1

 anvi-estimate-genome-completeness -p ./PROFILE.db -c ./contigs.db --list-collections
```
visualise
 ```
 srun --reservation=biol217 --pty --mem=10G --nodes=1 --tasks-per-node=1 --cpus-per-task=1 --partition=all /bin/bash
 ```
 node 010
 ```
 conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1

anvi-interactive -p ./PROFILE.db -c ./contigs.db -C METABAT
```
`open new terminal not in caucluster`
```
ssh -L 8060:localhost:8080 sunam236@caucluster-old.rz.uni-kiel.de
ssh -L 8080:localhost:8080 node010
```
open in google: http://127.0.0.1:8060
![image](images/Collection__consolidated_bins__for_merged_profiles.svg)
when finished: close second terminal with:
```
exit 
```
And close node as well
-----------------------------------------------
check binning quality for all three:
redirect to text file with: > genome_completeness_name

will be saved in working directory
```
anvi-estimate-genome-completeness -c ./contigs.db -p ./PROFILE.db -C consolidated_bins > genome_completeness_dastool
```
```
anvi-estimate-genome-completeness -c ./contigs.db -p ./PROFILE.db -C METABAT > genome_completeness_metabat2
```
```
anvi-estimate-genome-completeness -c ./contigs.db -p ./PROFILE.db -C CONCOCT > genome_completeness_concoct
```

----------------------------
-------------------------
-----------------------
# Day4 Bin refinement
In day5 folder
``` 
cd /work_beegfs/sunam236/Day5/
ls
```
create a script: script_anvi_summarize.sh <br>
to create a summary html
```
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=anvi_summarize
#SBATCH --output=anvi_summarize.out
#SBATCH --error=anvi_summarize.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

#load and activate anvio environment
module load miniconda3/4.7.12.1
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
#anvi-summarize
anvi-summarize -c ./contigs.db -p ./5_anvio_profiles/merged_profiles/PROFILE.db -C consolidated_bins -o ./5_anvio_profiles/summary --just-do-it
#this prints the required resources into your logfile
jobinfo
```
```
sbatch script_anvi_summarise.sh 
squeue -u sunam236
```
```
cd ./5_anvio_profiles/summary/bin_by_bin

mkdir ../../archea_bin_refinement

cp ./Bin_Bin_1_sub/*.fa ../../archea_bin_refinement/

cp ./Bin_METABAT__25/*.fa ../../archea_bin_refinement/
```
-----------------------------
## GUNC
```
conda activate /home/sunam226/gunc

cd ../../archea_bin_refinement
mkdir GUNC
```
create a new script: script_gunc.sh
```
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=gunc
#SBATCH --output=gunc.out
#SBATCH --error=gunc.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

#load and activate anvio environment
conda activate /home/sunam226/.conda/envs/gunc
#gunc
cd /work_beegfs/sunam236/Day5/5_anvio_profiles/archea_bin_refinement
for i in *.fa; do gunc run -i "$i" -r /home/sunam226/Databases/gunc_db_progenomes2.1.dmnd --out_dir GUNC --threads 10 --detailed_output; done
#this prints the required resources into your logfile
jobinfo
```
```
sbatch script_gunc.sh 
squeue -u sunam236
```
`look at the output file (.tsv) to see if chimeric or not (clade seperatio nscore)`

-------------------------------

## Manual bin refinement (only on the non-chimeric one)
remove the redundant parts

```
srun --reservation=biol217 --pty --mem=10G --nodes=1 --tasks-per-node=1 --cpus-per-task=1 /bin/bash
```
node=010
```
conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1

anvi-refine -c ./4_mapping/contigs.db -C consolidated_bins -p ./5_anvio_profiles/merged_profiles/PROFILE.db --bin-id Bin_METABAT__25
```
open new terminal
```
ssh -L 8060:localhost:8080 sunam236@caucluster-old.rz.uni-kiel.de
ssh -L 8080:localhost:8080 node010
```
open in google: http://127.0.0.1:8060
![image](images/Refining_Bin_METABAT__25_from__consolidated_bins.svg)

----------------------------------------------
# Day5 *`(we finally got there)`*

create script: script_taxonomy.sh
```
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=tax
#SBATCH --output=tax.out
#SBATCH --error=tax.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
#tax
anvi-run-scg-taxonomy -c ./4_mapping/contigs.db -T 20 -P 2
#this prints the required resources into your logfile
jobinfo
```
```
sbatch script_taxonomy.sh
```
create script: script_anvi_summarize2.sh
```
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=anvi_summarize2
#SBATCH --output=anvi_summarize2.out
#SBATCH --error=anvi_summarize2.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

#load and activate anvio environment
module load miniconda3/4.7.12.1
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
#anvi-summarize
anvi-summarize -c ./contigs.db -p ./5_anvio_profiles/merged_profiles/PROFILE.db -C consolidated_bins -o ./5_anvio_profiles/summary2 --just-do-it
#this prints the required resources into your logfile
jobinfo
```
```
sbatch script_anvi_summarize2.sh
```
rename bins_summary.txt to .tsv
open with libre office