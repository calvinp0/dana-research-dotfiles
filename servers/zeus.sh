#!/bin/bash
# Server-Specific Configurations for Zeus (zeus.technion.ac.il)

# Define User-Specific Paths (Dynamic for Zeus)
export rmgpy_path="/home/$USER/Code/RMG-Py/"
export rmgdb_path="/home/$USER/Code/RMG-database/"
export arc_path="/home/$USER/Code/ARC"
export t3_path="/home/$USER/Code/T3"
export tckdb_path="/home/$USER/Code/TCKDB/"

# Additional Aliases for Zeus
alias sb='qsub submit.sh'
alias st='qstat -u $USER'
alias runs='cd /home/$USER/runs'
