#!/bin/bash
# Server-Specific Configurations for Atlas (tech-ui02.hep.technion.ac.il)

# Define User-Specific Paths (Fixed for Atlas)
export rmgpy_path="/Local/ce_dana/Code/RMG-Py/"
export rmgdb_path="/Local/ce_dana/Code/RMG-database/"
export arc_path="/Local/ce_dana/Code/ARC"
export t3_path="/Local/ce_dana/Code/T3"

# Conda Initialization for Atlas
# >>> conda initialize >>>
__conda_setup="$('/Local/ce_dana/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Local/ce_dana/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Local/ce_dana/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Local/ce_dana/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Additional Aliases for Atlas
alias sb='condor_submit submit.sub'
alias st='condor_q -cons "Member(Jobstatus,{1,2})" -af:j "{\"0\",\"P\",\"R\",\"X\",\"C\",\"H\",\">\",\"S\"}[JobStatus]" RequestCpus RequestMemory JobName "(Time() - EnteredCurrentStatus)"'
