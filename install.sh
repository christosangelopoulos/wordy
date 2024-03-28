#! /bin/bash
#make script executable &copy it to the $PATH
chmod +x wordy.sh&&cp wordy.sh ~/.local/bin/
#Create the dir that will contain the
mkdir -p ~/.local/share/wordy/
cp wordy.png ~/.local/share/wordy/
echo -e  "DICTIONARY /usr/share/dict/words\nPREFERRED_EDITOR  nano">~/.local/share/wordy/wordy.config
