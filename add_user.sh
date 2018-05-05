#!/bin/bash
## Wi-Fi User Add script
function input(){
echo ENTER A USERNAME
read USERNAME

echo ENTER A PASSWORD
read PASSWORD

echo "IS THIS INFORMATION CORRECT?"
echo -e 'USERNAME:\t' $USERNAME
echo -e 'PASSWORD:\t' $PASSWORD
read ANSWER

if [[ $ANSWER == "Y" ]] || [[ $ANSWER == "y" ]] || [[ $ANSWER = "YES" ]] || [[ $ANSWER = "yes" ]]; then
    echo ""$USERNAME" Cleartext-Password := '"$PASSWORD"'" >> ~/Desktop/Userfile.txt
    exit 0
else
    echo "USER CANCELLED"
    input
fi
}

## Get user input
input