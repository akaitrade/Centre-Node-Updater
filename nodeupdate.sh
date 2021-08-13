#!/bin/bash
#Variables
SERVICE_NODE="node2"
SERVICE_SC="java"
FOLDERNAME='csnode1'
#Colors for Console
RED='\033[0;31m'
LRED='\033[0;31m'
WHITE='\033[0;37m'
NC='\033[0m' # No Color

 cat << "EOF"


  _____           _              _   _           _        _    _           _       _            
 / ____|         | |            | \ | |         | |      | |  | |         | |     | |           
| |     ___ _ __ | |_ _ __ ___  |  \| | ___   __| | ___  | |  | |_ __   __| | __ _| |_ ___ _ __ 
| |    / _ \ '_ \| __| '__/ _ \ | . ` |/ _ \ / _` |/ _ \ | |  | | '_ \ / _` |/ _` | __/ _ \ '__|
| |___|  __/ | | | |_| | |  __/ | |\  | (_) | (_| |  __/ | |__| | |_) | (_| | (_| | ||  __/ |   
 \_____\___|_| |_|\__|_|  \___| |_| \_|\___/ \__,_|\___|  \____/| .__/ \__,_|\__,_|\__\___|_|   
                                                                | |                             
                                                                |_|                             


EOF

#Welcome Tekst
echo "\n\nStarting Centre Create or Update Script Targeted Software Credits Blockchain Node\n"

#Function Declerations

CreateNode () {
  echo "Creating New Node"
}

UpdateNode () {
  echo "Updating current node"
}

#Verify that Processes are stopped
if pgrep -x "$SERVICE_NODE" >/dev/null
then
    echo "${RED}$SERVICE_NODE is still running please CTRL C the node software${NC}\n"
    return
else
    echo "${WHITE}$SERVICE_NODE process not running updater can continue${NC}\n"
    if pgrep -x "$SERVICE_SC" >/dev/null
    then
        echo "${LRED}$SERVICE_SC is still running do you want to kill the process (Recommended) ${WHTIE}yes or no ?${NC}\n"
        read javaanswer
        if [ "$javaanswer" = "yes" ]
        then
            echo "Killing Java Processes"
            killall java
            sleep 2
            if pgrep -x "$SERVICE_SC" >/dev/null
            then
                echo "failed to kill please try again"
                return
            else
                echo "No Java Processes found Kill was a success !\n"
                echo "${WHITE}Updater will Continue now${NC}\n"
                echo "Checking if $FOLDERNAME folder exists"
                if [ -d "$FOLDERNAME" ] 
                then
                    echo "${WHITE}$FOLDERNAME folder found proceding with update procedure${NC}\n" 
                    UpdateNode
                else
                    echo "${LRED}$FOLDERNAME folder does not exist do you want install the Credits node software ?${WHTIE} yes or no${NC}\n"
                    read installanswer
                    if [ "$installanswer" = "yes" ]
                    then
                        echo "Proceding with installing Credits Node"
                        CreateNode
                    else
                        echo "Aborting"
                        return
                    fi
                fi
                
            fi    
        else
            echo "Aborting"
            return
        fi
        return
    else
        echo "${WHITE}$SERVICE_SC process not running updater can continue\n${NC}"
        echo "Do you want to continue? yes or no\n"
        read answer
        if [ "$answer" = "yes" ]
        then
            echo "Checking if $FOLDERNAME folder exists"
                if [ -d "$FOLDERNAME" ] 
                then
                    echo "\n${WHITE}$FOLDERNAME folder found proceding with update procedure${NC}\n" 
                    UpdateNode
                else
                    echo "${LRED}$FOLDERNAME folder does not exist do you want install the Credits node software ? ${WHTIE} yes or no${NC}\n"
                    read installanswer
                    if [ "$installanswer" = "yes" ]
                    then
                        echo "Proceding with installing Credits Node"
                        CreateNode
                    else
                        echo "Aborting"
                        return
                    fi
                fi
        else
            echo "Aborting"
            return
        fi
    fi
    

fi

#pidof ./node