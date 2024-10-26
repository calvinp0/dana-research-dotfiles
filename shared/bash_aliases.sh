#!/bin/bash

# Reload bash
alias rc='source ~/.bashrc'

# Edit bashrc - nano
alias erc='nano ~/.bashrc'
alias erca='nano ~/.bash_aliases'

# Edit bashrc - vim
alias vrc='vim ~/.bashrc'
alias vrca='vim ~/.bash_aliases'

# Conda Environment Activation
alias rmge='conda activate rmg_env'
alias arce='conda activate arc_env'
alias tcke='conda activate tck_env'
alias t3e='conda activate t3_env'
alias deact='conda deactivate'

# Change directory
alias rmgcode='cd $rmgpy_path'
alias dbcode='cd $rmgdb_path'
alias arcode='cd $arc_path'
alias t3code='cd $t3_path'


# Run Scripts with Logging
alias rmg='python-jl $rmgpy_path/rmg.py input.py > >(tee -a stdout.log) 2> >(tee -a stderr.log >&2)'
alias arkane='python-jl $rmgpy_path/Arkane.py input.py > >(tee -a stdout.log) 2> >(tee -a stderr.log >&2)'
alias arc='python $ARC_PATH/ARC.py input.yml > >(tee -a stdout.log) 2> >(tee -a stderr.log >&2)'
alias arcrestart='python $arc_path/ARC.py restart.yml > >(tee -a stdout.log) 2> >(tee -a stderr.log >&2)'
alias restartarc='python $arc_path/ARC.py restart.yml > >(tee -a stdout.log) 2> >(tee -a stderr.log >&2)'
alias t3='python $t3_path/T3.py input.yml > >(tee -a stdout.log) 2> >(tee -a stderr.log >&2)'
