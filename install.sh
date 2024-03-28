#! /bin/bash
#make script executable &copy it to the $PATH
chmod +x wordy.sh&&cp wordy.sh ~/.local/bin/
#Create the dir that will contain the
mkdir -p ~/.local/share/wordy/ ~/.config/wordy/
cp wordy.png ~/.local/share/wordy/
echo -e  "WORD_LIST /usr/share/dict/words\nPREFERRED_EDITOR  $EDITOR">~/.config/wordy/wordy.config
