#! /bin/bash
#make script executable &copy it to the $PATH
chmod +x wordy.sh
[[ -d $HOME/.local/bin/ ]]&&cp wordy.sh $HOME/.local/bin/&&INSTALL_MESSAGE="The script was copied to\n\e[33m $HOME/.local/bin/\e[m\nProvided that this directory is included in the '\$PATH', the user can run the script with\n\e[33m$ wordy.sh\e[m\nfrom any directory.\nAlternatively, the script can be run with\n\e[33m$ ./wordy.sh\e[m\nfrom the wordy/ directory."||INSTALL_MESSAGE="The script has been made executable and the user can run it with:\n\e[33m$ ./wordy.sh\e[m\nfrom the wordy/ directory."

#Create the dir that will contain the
mkdir -p ~/.local/share/wordy/ ~/.config/wordy/
cp wordy.png ~/.local/share/wordy/
echo -e  "WORD_LIST=/usr/share/dict/words
PREFERRED_EDITOR=${EDITOR-nano}">~/.config/wordy/wordy.config
echo -e "$INSTALL_MESSAGE"
