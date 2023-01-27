# Day_5
*`continue of day 3`*

## MAGs quality estimation
See the amoubt of bins 
```
module load miniconda3/4.7.12.1
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1

anvi-estimate-genome-completeness -c ./contigs.db -p ./PROFILE.db -C consolidated_bins
```
```
 anvi-estimate-genome-completeness -p ./PROFILE.db -c ./contigs.db --list-collections
```
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

