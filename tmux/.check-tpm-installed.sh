#!/bin/bash	


# Check if the TPM is installed

if [ -d $HOME/.tmux/plugins/tpm ]; then
	exit 0;
else
	exit 2;
fi

