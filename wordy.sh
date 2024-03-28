#! /bin/bash
#     ╭───╮╭───╮╭───╮╭───╮╭───╮
#     │ W ││ O ││ R ││ D ││ Y │
#     ╰───╯╰───╯╰───╯╰───╯╰───╯
#A bash script written by Christos Angelopoulos, September 2023, under GPL v2

function show_letters ()
{
 echo -e "     ${Y}╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮     \n     │ L ││ E ││ T ││ T ││ E ││ R ││ S │     \n     ╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯ ${n}    \n\n"
 echo -e "          ${G}╭───╮╭───╮╭───╮╭───╮╭───╮     \n  WORD:   │ ${SHOW_WORD[0]^^} ││ ${SHOW_WORD[1]^^} ││ ${SHOW_WORD[2]^^} ││ ${SHOW_WORD[3]^^} ││ ${SHOW_WORD[4]^^} │     \n          ╰───╯╰───╯╰───╯╰───╯╰───╯ ${n}    \n"
 RED_LETTERS="$(echo $(echo $RED_LETTERS|sed 's/ / \n/g'|sort -h))"" "
 YELLOW_LETTERS="$(echo $(echo $YELLOW_LETTERS|sed 's/ / \n/g'|sort -h))"" "
 echo -e "  ${Y}MISPLACED LETTERS : $YELLOW_LETTERS\n  ${R}ABSENT LETTERS    : $RED_LETTERS\n  ${C}UNUSED LETTERS    : $CYAN_LETTERS${n}\n\n${B}Press any key to return${n}"
 read -sN 1 v;clear;

}

function quit_puzzle ()
{
 echo -e "     ${G}╭───╮${R}╭───╮╭───╮╭───╮╭───╮     \n     ${G}│ U │${R}│ Q ││ U ││ I ││ T │     \n     ${G}╰───╯${R}╰───╯╰───╯╰───╯╰───╯ ${n}    \n\n"
 A=${SOLUTION^^}
 echo -e "${Y}The word you were looking for was:"
 echo -e "     ${G}╭───╮╭───╮╭───╮╭───╮╭───╮     \n     │ ${A:0:1} ││ ${A:1:1} ││ ${A:2:1} ││ ${A:3:1} ││ ${A:4:1} │     \n     ╰───╯╰───╯╰───╯╰───╯╰───╯ ${n}    "
 echo -e "\n${B}Press any key to return${n}"
 read -sN 1 v;clear;
 #db2="M"
 }

function show_statistics () {
 echo -e "     ${Y}╭───╮╭───╮╭───╮╭───╮╭───╮     \n     │ S ││ T ││ A ││ T ││ S │     \n     ╰───╯╰───╯╰───╯╰───╯╰───╯ ${n}    \n\n"
 if [[ -f $HOME/.local/share/wordy/statistics.txt ]]&&[[ -n $(cat $HOME/.local/share/wordy/statistics.txt) ]]
 then
  PLAYED="$(cat $HOME/.local/share/wordy/statistics.txt|wc -l)"
  WON="$(grep 'win' $HOME/.local/share/wordy/statistics.txt|wc -l)"
  SUC_RATIO="$(echo "scale=2; $WON *100/ $PLAYED" | bc)"
  RECORD="$(sort $HOME/.local/share/wordy/statistics.txt|head -1|awk '{print $1}')"
  MAX_ROW="$(uniq -c -s 1 $HOME/.local/share/wordy/statistics.txt|sort -rh|head -1|awk '{print $1}')"
  if [[ "$(tail -1 $HOME/.local/share/wordy/statistics.txt)" == "lose" ]]
  then
  CURRENT_ROW="0"
  else
  CURRENT_ROW="$(uniq -c -s 1 ~/.local/share/wordy/statistics.txt |tail -1|awk '{print $1}')"
  fi
  echo -e "${C}\tGames Played   : $PLAYED";sleep 0.3
  echo -e "${M}\tGames Won      : $WON";sleep 0.3
  echo -e "${G}\tGames Lost     : $(($PLAYED-$WON))";sleep 0.3
  echo -e "${Y}\tSuccess ratio  : $SUC_RATIO%";sleep 0.3
  echo -e "${R}\tRecord Guesses : $RECORD";sleep 0.3
  echo -e "${W}\tRecord streak  : $MAX_ROW wins";sleep 0.3
  echo -e "${T}\tCurrent streak : $CURRENT_ROW wins${n}";sleep 0.3
 else
  echo -e "${B}No statistics available at the moment."
 fi
}

function win_game ()
{
 clear
 ((TRY++))
 echo "$TRY win">>$HOME/.local/share/wordy/statistics.txt
 PLACEHOLDER_STR=$SOLUTION
 F[TRY]="GGGGG"
 print_box
 echo -e "${B}╰───────────────────────────────────╯${n}"
 A=${PLACEHOLDER_STR^^}
 echo -e "${Y}Congratulations!\nYou found the word:"
 echo -e "     ${G}╭───╮╭───╮╭───╮╭───╮╭───╮     \n     │ ${A:0:1} ││ ${A:1:1} ││ ${A:2:1} ││ ${A:3:1} ││ ${A:4:1} │     \n     ╰───╯╰───╯╰───╯╰───╯╰───╯ ${n}    "
 echo -e "${Y}after ${R}$TRY ${Y}tries!${n}\n"
 echo -e "\n${B}Press any key to return${n}"
 read -sN 1 v;clear;
 db2="Q"
}

function lose_game ()
{
 clear
 echo "lose">>$HOME/.local/share/wordy/statistics.txt
 PLACEHOLDER_STR=$SOLUTION
 F[TRY]="GGGGG"
 print_box
 echo "╰───────────────────────────────────╯"
 echo -e "${Y}You lost!\nAfter ${R}6${Y} tries,\n it was not possible to find the word\n"
 A=${PLACEHOLDER_STR^^}
echo -e "     ${G}╭───╮╭───╮╭───╮╭───╮╭───╮     \n     │ ${A:0:1} ││ ${A:1:1} ││ ${A:2:1} ││ ${A:3:1} ││ ${A:4:1} │     \n     ╰───╯╰───╯╰───╯╰───╯╰───╯ ${n}    "
 echo -e "\n${B}Press any key to return${n}";read -sN 1 v;clear;
 db2="Q"
}

function check_guess ()
{
 F0=('R' 'R' 'R' 'R' 'R')
 for q in {0..4}
 do
  if [[ "$SOLUTION" == *"${WORD_STR:q:1}"* ]]&&[[ $(echo ${WORD_STR:q:1}) != ${SOLUTION:q:1} ]]
  then F0[q]="Y"
  fi
  if [[ "$SOLUTION" == *"${WORD_STR:q:1}"* ]]&&[[ $(echo ${WORD_STR:q:1}) == ${SOLUTION:q:1} ]]&&[[ $(echo $WORD_STR|grep -o ${WORD_STR:q:1}|wc -l) -gt 1 ]]
  then F0[q]="Y"
  fi
  if [[ $(echo ${WORD_STR:q:1}) == ${SOLUTION:q:1} ]]
  then
   F0[q]="G"
  fi
  F[TRY]=$(echo ${F0[@]}|sed 's/ //g')
  #show_letters conditionals
  g="${WORD_STR:q:1}"" "
  if [[ ${F0[q]} == "R" ]]
  then
   if [[ "$RED_LETTERS" != *"$g"* ]];then RED_LETTERS="$RED_LETTERS""$g";fi
   CYAN_LETTERS="${CYAN_LETTERS/$g/}"
  fi
  if [[ ${F0[q]} == "Y" ]]
  then
   if [[ "$YELLOW_LETTERS" != *"$g"* ]];then YELLOW_LETTERS="$YELLOW_LETTERS""$g";fi
   CYAN_LETTERS="${CYAN_LETTERS/$g/}"
  fi
  if [[ ${F0[q]} == "G" ]]
  then
   SHOW_WORD[q]=${WORD_STR:q:1}
   CYAN_LETTERS="${CYAN_LETTERS/$g/}"
   YELLOW_LETTERS="${YELLOW_LETTERS/$g/}"
  fi
 done
 COMMENT=" Enter a 5-letter word"
}

function enter_word () {
 if [[ ${#WORD_STR} -lt 5 ]]
 then COMMENT=" Word is too small!"
 elif [[ ${#WORD_STR} -gt 5 ]]
 then COMMENT=" Word too big!"
 elif [[ -z "$(echo $TOTAL_SOLUTIONS|sed 's/ /\n/g'|grep  -E ^"$WORD_STR"$)" ]]
 then COMMENT=" Invalid word, not in solutions"
 else
  COMMENT=" Last word: $WORD_STR"
  GUESS[$TRY]=$WORD_STR
  check_guess
  if [[ "${F[TRY]}" == "GGGGG" ]]
  then win_game
  main_menu_reset
  else
   ((TRY++))
   if [[ $TRY -ge 6 ]]
    then lose_game
    main_menu_reset
   fi
  fi
 fi
 WORD_STR="";PLACEHOLDER_STR="$WORD_STR""$PAD"
 COMMENT_STR="$COMMENT""$PAD"
}

function main_menu_reset () {
for i in {0..5}
do
 F[i]=""
done
}

function print_box () {
 echo -e "${B}╭───────────────────────────────────╮"
t=0
while [[ $t -lt $TRY ]]
do
 A="${GUESS[$t]^^}"
 K0="${F[$t]}"
 for a in {0..4}
 do
  if [[ ${K0:a:1} == "Y" ]];then K[a]="${Y}";
  elif [[ ${K0:a:1} == "G" ]];then K[a]="${G}";
  elif [[ ${K0:a:1} == "R" ]];then K[a]="${R}";fi
 done
echo -e "${B}│     ${K[0]}╭───╮${K[1]}╭───╮${K[2]}╭───╮${K[3]}╭───╮${K[4]}╭───╮${B}     │\n│     ${K[0]}│ ${A:0:1} │${K[1]}│ ${A:1:1} │${K[2]}│ ${A:2:1} │${K[3]}│ ${A:3:1} │${K[4]}│ ${A:4:1} │     ${B}│\n│     ${K[0]}╰───╯${K[1]}╰───╯${K[2]}╰───╯${K[3]}╰───╯${K[4]}╰───╯     ${B}│"
 ((t++))
done
if [[ ${F[TRY]} != "GGGGG" ]]
then
A=${PLACEHOLDER_STR^^}
echo -e "${B}│     ╭───╮╭───╮╭───╮╭───╮╭───╮     │\n│     │${n} ${A:0:1} ${B}││${n} ${A:1:1} ${B}││${n} ${A:2:1} ${B}││${n} ${A:3:1} ${B}││${n} ${A:4:1} ${B}│     │\n│     ╰───╯╰───╯╰───╯╰───╯╰───╯     │"
  echo  -e "${B}├───────────────────────────────────┤"
fi
}

function rules() {
 echo -e "You have 6 guesses to find out the secret 5-letter word.

${G}╭───╮
${G}│ F │
${G}╰───╯${n}
If a letter appears ${R}green${n},that means that this letter
${G}exists in the secret word, and is in the right position.${n}

\t${Y}╭───╮
\t${Y}│ F │
\t${Y}╰───╯${n}
If a letter appears ${Y}yellow${n},that means that this letter
${Y}exists in the secret word, but is in NOT the right position.${n}

\t\t${R}╭───╮
\t\t${R}│ F │
\t\t${R}╰───╯${n}
If a letter appears ${R}red${n},that means that this letter
${R}does NOT appear in the secret word AT ALL.${n}
As mentioned above, there are ${Y}6 guesses${n} to find the secret word.
${Y}GOOD LUCK!${n}
\n\n${B}Press any key to return${n}"
read -sN 1 v
clear
}

function new_game()
{
 PAD="                                      "
 COMMENT=" Enter 5 letter word"
 COMMENT_STR="$COMMENT"${PAD}
 PLACEHOLDER_STR="$WORD_STR${PAD}"
 SOLUTION="$(grep -v "'" "$WORD_LIST"|grep -v -E [ê,è,é,ë,â,à,ô,ó,ò,ú,ù,û,ü,î,ì,ï,í,ç,ö,á,ñ]|grep -v 'xx'|grep -v 'vii'|grep -v '[^[:lower:]]'|grep -E ^.....$|shuf|head -1)"
 TRY=0
 CYAN_LETTERS="a b c d e f g h i j k l m n o p q r s t u v w x y z "
 RED_LETTERS=""
 YELLOW_LETTERS=""
 SHOW_WORD=("_" "_" "_" "_" "_")
}

function play_menu () {
 db2="";
#detect BACKSPACE, solution found https://stackoverflow.com/questions/4196161/bash-read-backspace-button-behavior-problem
backspace=$(cat << eof
0000000 005177
0000002
eof
)
 while [[ $db2 != "Q" ]]
 do
  print_box
  echo -en "│   ${Y}<enter>${n}    to ${G}ACCEPT word${n}       ${B}│\n│  ${Y}<delete>${n}    to ${R}ABORT word        ${B}│\n│ ${Y}<backspace>${n}  to ${R}DELETE letter${B}     │\n├───────────────────────────────────┤\n│      ${Y}L${n}       to show ${C}LETTERS${B}      │\n│      ${Y}W${n}       to show ${C}WORD LIST${B}    │\n├───────────────────────────────────┤\n│      ${Y}Q${n}       to ${R}QUIT GAME${B}         │\n├───────────────────────────────────┤\n│${n}${COMMENT_STR:0:35}${B}│\n╰───────────────────────────────────╯\n${n}"

  read -sn 1 db2;
  if [[ $(echo "$db2" | od) = "$backspace" ]]&&[[ ${#WORD_STR} -gt 0 ]];then  WORD_STR="${WORD_STR::-1}";PLACEHOLDER_STR="$WORD_STR""$PAD";fi;
  case $db2 in
    "Q") clear;quit_puzzle;db="";main_menu_reset;
    ;;
    [a-z]) clear;if [[ ${#WORD_STR} -le 5 ]];then WORD_STR="$WORD_STR""$db2";PLACEHOLDER_STR="$WORD_STR""$PAD";fi;
    ;;
    "") clear;enter_word;
    ;;
    "3") clear; WORD_STR="";PLACEHOLDER_STR="$WORD_STR""$PAD";
    ;;
    "W") clear; echo -e "     ${Y}╭───╮╭───╮╭───╮╭───╮  ╭───╮╭───╮╭───╮╭───╮\n     │ W ││ O ││ R ││ D │  │ L ││ I ││ S ││ T │\n     ╰───╯╰───╯╰───╯╰───╯  ╰───╯╰───╯╰───╯╰───╯ ${n}\n\n"
    grep -v "'" "$WORD_LIST"|grep -v -E [ê,è,é,ë,â,à,ô,ó,ò,ú,ù,û,ü,î,ì,ï,í,ç,ö,á,ñ]|grep -v 'xx'|grep -v 'vii'|grep -v '[^[:lower:]]'|grep -E ^.....$|column -x -c 80;
    echo -e "${B}Press any key to return${n}";read -sN 1 v;clear;
    ;;
    "L") clear;show_letters;
    ;;
    *)clear;
  esac
 done
}
function cursor_reappear() {
tput cnorm
exit
}
function load_config()
{
 config_fail=0
 WORD_LIST=$(awk '/WORD_LIST/ {print $2}' ~/.config/wordy/wordy.config)
 PREFERRED_EDITOR=$(awk '/PREFERRED_EDITOR/ {print $2}' ~/.config/wordy/wordy.config)
 [[ -z ~/.config/wordy/wordy.config ]]&&config_fail=1
 [[ -z $WORD_LIST ]]&&WORD_LIST="/usr/share/dict/words"&&config_fail=1
 [[ -z $PREFERRED_EDITOR ]]&&PREFERRED_EDITOR="nano"&&config_fail=1
 [[ $config_fail == 1 ]]&&notify-send -t 9000 -i $HOME/.local/share/wordy/wordy.png "Configuration file was not loaded properly.
Wordy is running with default configuration.";
}

function main_menu()
{
 clear
 db=""
 while [ "$db" != "5" ]
 do
  echo -e "${B}╭───────────────────────────────────╮"
  echo -e "${B}│     ${G}╭───╮${G}╭───╮${G}╭───╮${G}╭───╮${R}╭───╮     ${B}│\n│     ${G}│ W │${G}│ O │${G}│ R │${G}│ D │${R}│ Y │     ${B}│\n│     ${G}╰───╯${G}╰───╯${G}╰───╯${G}╰───╯${R}╰───╯     ${B}│\n├───────────────────────────────────┤\n│   ${C}Find the hidden 5 letter word${n}   ${B}│"
  echo -en "├───────────────────────────────────┤\n│${n}Enter:                             ${B}│\n│ ${Y}1${n} to ${G}Play New Game.${B}               │\n│ ${Y}2${n} to ${C}Read the Rules.${B}              │\n│ ${Y}3${n} to ${C}Show Statistics.${B}             │\n│ ${Y}4${n} to ${M}Configure Game.${B}              │\n│ ${Y}5${n} to ${R}Exit.${B}                        │\n"
  echo  -e "╰───────────────────────────────────╯${n}\n"
  read -sN 1  db
  case $db in
   1) clear;new_game; play_menu;clear;
   ;;
   2) clear;rules;
   ;;
   3) clear;show_statistics;echo -e "${B}\nPress any key to return${n}";read -sN 1 v;tput civis;clear;
   ;;
   4) clear;eval $PREFERRED_EDITOR ~/.config/wordy/wordy.config;load_config;tput civis;clear;
   ;;
   5) clear;notify-send -t 5000 -i $HOME/.local/share/wordy/wordy.png "Exited Wordy";
   ;;
   *)clear;echo -e "\n😕 ${Y}$db${n} is an invalid key, please try again.\n"   ;
  esac
 done
}
function load_colors()
{
R="\e[31m"
G="\e[32m"
Y="\e[33m"
T="\e[34m"
M="\e[35m"
C="\e[36m"
W="\e[37m"
B="\e[38;5;242m"
n="\e[m"
}

#===============================================================================
load_colors
load_config
TOTAL_SOLUTIONS="$(grep -v "'" "$WORD_LIST"|grep -v -E [ê,è,é,ë,â,à,ô,ó,ò,ú,ù,û,ü,î,ì,ï,í,ç,ö,á,ñ]|grep -v 'xx'|grep -v 'vii'|grep -v '[^[:lower:]]'|grep -E ^.....$)"
trap cursor_reappear HUP INT QUIT TERM EXIT ABRT
tput civis # make cursor invisible

main_menu_reset
main_menu
