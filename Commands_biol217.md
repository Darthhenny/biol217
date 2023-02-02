-open Terminal --> ctr-alt-t
    pw: unikiel

    Create code in visual code studio mit markdown

sunam (supercomputer): 236 --> ssh -X sunam236@caucluster.rz.uni-kiel.de
    -Pw:biol217_2022

-clear screen --> ctr l
-redo previous command --> Arrowup
-stop processes --> ctr c
-copy or past --> ctrl shift c/v

-target all files of the same type --> *  (*.txt, *.pdf)
-target previous directy --> (command) ..
    (every previous directory need one more .)
-target something in a directoy --> ./(directoyname)/(filename)
    (example= rm ./test1/*.fastq)

-see in which folder(directory) u are --> pwd
-see all directory available --> ls 
    -see information as well  --> ls -l
    -show hidden files        --> ls -a
-change directory --> cd (Directoryname)
    -go back one directory --> cd ..
-make a directory --> mkdir (Directoryname)
-remove directory --> rm -r (Directoryname)
-make a file --> touch (Filename)
-remove file --> rm (Filename)
    -remove all files of one type --> rm *.(file type like)
-move to folder --> mv (filename) (directoryname)
-rename file --> mv (currentfilename) (newfilename)
-copy file --> cp (filename)
    -copy to other folder --> cp (filename) (new directory9
     -copy file to previous directory --> cp (filename) ..\

-head (see the first 10 lines of a file)
-tail (see the last 10 lines of a file)

-edit a file --> cat >> (filename)
    -wedit anything
    -when finished --> ctr C
-show the content of one or more file --> cat (filename1) (filename2)

-Download files --> wger (link)
-unzip file --> gunzip (filename)
-compress file --> gzip (filename)
    gz is zipped

edit permission to file --> chmod (user)+/-(permission type) (filename)
                            chmod g-rw (filename)
    -u (you)
    -g (group)
    -o (others)
        -+/-r (read)
        -+/-w (write)
        -+/-x (execute)

install programm --> sudo apt-get install (softwarename)
start software --> (softwarename)
stop software --> ctrl c
software running in background and terminal for other things--> (softwarename) &

-----------------------------------------------------------------------------------------
Working on supercomputer
sunam (supercomputer): 236 --> ssh -X sunam236@caucluster.rz.uni-kiel.de
    -Password:biol217_2022
    2 directorys ($WORK and $HOME)
        -home for installing
        -work for working
Log out --> crtl dcd
Data will be available in  --> /home/sunam236
Edit GUI via FILE-connect to server 
    -Server:caucluster.rz.uni-kiel.de Type:SHH Folder:/home/sunam236  or /work_beegfs/sunam236  

-show active path --> pwd
-show installed software --> module avail
-activate software --> module load (Name)
-deactivate software --> module unload (name)
    -deactivate all software --> module purge


-submit a script --> sbatch <jobscript>
-see the status --> squeue -u sunam236

------------------------------------------------------------------
Environments (specific room for certin tasks): Conda/Miniconda

-Check how many environments are already there --> conda env list
-see how many softwares are installed --> conda list

-Aktivieren/Deactivieren --> conda activate/deactivate
-create a new environment --> conda create -n rna_seq

----------------------------------------------
Push to Github:
-either via visual studio connection
-or via the website
-or via Console:
setup github
```
git config --global user.name "Name"
git config --global user.email "email"
git init
git clone [url to repo]
```
push to github
```
git status
git add
git status
git commit -m "[descriptive message]"