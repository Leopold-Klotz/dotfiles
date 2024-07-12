if [[ $(hostname) == os1.engr.oregonstate.edu ]]
then
  if [ -r /class/local/etc/bash_profile ]
  then
    source /class/local/etc/bash_profile
    return
  fi
fi

source ~/.bashrc
# This file (.bash_profile) is read when you login to a machine
# The .bashrc is read when a shell is started.  We're basically 
# going to use one file.  But, if you feel the need, you could
# separate some functionality.
# 
source ~/.bashrc
