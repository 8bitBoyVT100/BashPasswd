#! /usr/bin/env bash

# Welcome message
welcome (){
    printf "\e[0m\e[1;91m----------------------------------\e[0m \n"
    printf "\e[0m\e[1;91m|\e[0m\en Welcome to GPG PasswordManager \e[0m\e[1;91m|\e[0m\n"
    printf "\e[0m\e[1;91m----------------------------------\e[0m \n"
}

wencrypt(){
    printf "\e[0m\e[1;92m######################\e[0m \n"
    printf "\e[0m\e[1;92m#\e[0m\en\tEncrypt\e[0m\e[1;92m      #\e[0m\n"
    printf "\e[0m\e[1;92m######################\e[0m \n"
}

wdecrypt(){
    printf "\e[0m\e[1;95m#######################\e[0m \n"
    printf "\e[0m\e[1;95m#\e[0m\en\tDecrypt\e[0m\e[1;95m       #\e[0m\n"
    printf "\e[0m\e[1;95m#######################\e[0m \n"
}

wabout (){
    printf "\e[0m\e[1;32m######################\e[0m \n"
    printf "\e[0m\e[1;32m#\e[0m\en\tAbout\e[0m\e[1;32m        #\e[0m\n"
    printf "\e[0m\e[1;32m######################\e[0m \n"
}

whelp (){
    printf "\e[0m\e[33m######################\e[0m \n"
    printf "\e[0m\e[33m#\e[0m\en\tHelp\e[0m\e[33m         #\e[0m\n"
    printf "\e[0m\e[33m######################\e[0m \n"
}

wlist (){
    printf "\e[0m\e[1;33m####################\e[0m \n"
    printf "\e[0m\e[1;33m#\e[0m\en\tVault\e[0m\e[1;33m      #\e[0m\n"
    printf "\e[0m\e[1;33m####################\e[0m \n"
}

#==============================================================[ Options ]======================================================
# Options for the action
options () {
    clear
    welcome
    printf "\e[1;92m[\e[0m\e[1;77m01\e[0m\e[1;92m]\e[0m\e[1;91m Encrypt\e[0m      \e[1;92m[\e[0m\e[1;77m02\e[0m\e[1;92m]\e[0m\e[1;91m Decrypt\e[0m \n"
    printf "\e[1;92m[\e[0m\e[1;77m03\e[0m\e[1;92m]\e[0m\e[1;91m About\e[0m        \e[1;92m[\e[0m\e[1;77m04\e[0m\e[1;92m]\e[0m\e[1;91m Help\e[0m \n"
    printf "\e[1;92m[\e[0m\e[1;77m05\e[0m\e[1;92m]\e[0m\e[1;91m Vault\e[0m        \e[1;92m[\e[0m\e[1;77m06\e[0m\e[1;92m]\e[0m\e[1;91m Exit\e[0m \n"

    read -p $'\n\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Choose an option: \e[0m\en' option 

    if [[ $option == 1 || $option == 01 ]] 
    then
        check_encrypt
    elif [[ $option == 2 || $option == 02 ]] 
    then
        check_decrypt
    elif [[ $option == 3 || $option == 03 ]] 
    then
        about
    elif [[ $option == 4 || $option == 04 ]] 
    then
        help
    elif [[ $option == 5 || $option == 05 ]] 
    then
        list_service
    elif [[ $option == 6 || $option == 06 ]] 
    then
        exit
    else
        echo "[*] Invalid input. Exiting... "
        sleep 1
        exit 0
    fi
}

#===============================================[ List Manager ]=====================================================

manager () {
    printf "==============================\n"
    printf "\e[1;92m[\e[0m\e[1;77m01\e[0m\e[1;92m]\e[0m\e[1;91m Decrypt\e[0m      \e[1;92m[\e[0m\e[1;77m02\e[0m\e[1;92m]\e[0m\e[1;91m Remove\e[0m\n"

    read -p $'\n\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Choose an option: \e[0m\en' mtion

    if [[ $mtion == 1 || $mtion == 01 ]] 
    then
        check_decrypt
    elif [[ $mtion == 2 || $mtion == 02 ]] 
    then
        get_service
        if [[ -f "./Passwords/$keyword.gpg" ]]
        then
            printf "[*] Are you sure you want to delete\e[1;92m $keyword.gpg\e[0m? [y/N]: "
            read rcheck
            case $rcheck in
                [yY]* )
                    rm "./Passwords/$keyword.gpg"
                    echo "[*] Deleted"
                    echo "[*] Refreshing.."
                    sleep 1.5
                    list_service;;
                [nN]* )
                    echo "[*] Aborted.."
                    list_service;;
                * )
                    echo "[*] Aborted.."
                    list_service
            esac
        else
        echo "[*] Service not found. Refreshing"
        sleep 1.5
        list_service
        fi
    elif [[ $mtion == "" ]] 
    then
    echo "[*] Hold your horse..."
        sleep 1
        options
    else
        echo "[*] Invalid input. Refreshing..."
        sleep 1.5
        list_service
    fi
}
# what="https://www.youtube.com/watch?v=dQw4w9WgXcQ"

#====================================================[ Continue Function ]========================================
enter_to_continue (){
    printf "\n[*] Press enter to continue... "
    read enter 
    if [[ $enter == "" ]]
    then
    options
    else
    options
    fi
}
#============================================================================================================

# Passwords Directory Check
checkdir (){
    if [[ -d Passwords ]]
    then    
    echo "[*] Running a check..."
    sleep 0.5
    else
    echo "[*] Making the password directory..."
    sleep 0.5
    mkdir -p ./Passwords
    fi
}

#=========================================================[ Servies ]==================================================
# Get the name of the service
get_service (){
checkdir
echo ""
printf "[*]\e[0m\e[1;36m Enter the Keyword for the Service:\e[0m "
# ==> Will implement array, rather than a normal variable in future
read checkword
keyword=${checkword,,} # ==> turing it into lowercase 
}

#==================================================[ Saved GPG Keys ]========================================================
# list all encrypted gpg files, [ the vault ]
list_service () {
    clear
    wlist
    printf "\e[0m\e[1;91m---------------------\e[0m \n"
    ls ./Passwords/ > tmp.txt && awk 'BEGIN{ORS="\n"} {print NR,$0}' tmp.txt && rm tmp.txt
    printf "\e[0m\e[1;91m---------------------\e[0m \n"
    manager
}
#===============================================================================================================================

#======================================================[ Encryption ]========================================================

# Checks wheather the service or the file related to it exist or not
check_encrypt (){
clear
wencrypt
get_service
if [ -f "./Passwords/$keyword.gpg" ]
then
    printf "[*]\e[0m\e[1;32m A common Service seems to exist, Plz check the Password folder\n\e[0m"
    read -r -p "[*] Do you want to continue ? This may override the existing file [y/N]: " check

    case $check in
        [yY]* )
        encryption;;
        [nN]* )
        echo "[*] Terminating Process..."
        sleep 1.2
        options
        exit 0;;
        * )
        echo "[*] Terminating Process..."
        sleep 1.2
        check_encrypt
        exit 0;;
    esac
elif [[ $keyword == "" ]]
then
        echo "[*] No service was found."
        sleep 1
        options
else
    encryption
fi
}
encryption () {
    printf "[*] Are you sure you want to create this service named\e[1;32m $keyword\e[0m? [y/N]: "
    read chec2

    case $chec2 in
    [yY]* )
        echo -n "[*] Enter the password for the service $keyword : "
        read -s passwd
        echo "" 
        echo -n "[*] Re-enter the password to confirm : "
        read -s passwd2
        if [[ $passwd == $passwd2 && $passwd != "" && $passwd2 != " " ]]
        then
            printf "\n[*]\e[0m\e[1;92m password confirmed\e[0m\n"
            echo "[*] Initializaing MasterKey Prompt...."
            sleep 2
             # I will be implementinh base64 or other hases types later..
             mkdir ./Passwords/tmp  && touch "./Passwords/tmp/$keyword" && echo $passwd2 > "./Passwords/tmp/$keyword"
             gpg --cipher-algo AES-256 -c --no-symkey-cache  ./Passwords/tmp/$keyword && mv ./Passwords/tmp/*.gpg ./Passwords
             rm -rf ./Passwords/tmp
             # can be made simple, but for now it's ok
                echo "[*] Key Saved. Initializing Main Menu..."
                sleep 2
                options
        elif  [[ $passwd = ""  ||  $passwd2 = "" ]]
        then
            echo -e "\n[*] Couldn't verify it as an apropriate password.."
            echo "[*] Process Terminated. Refreshing...."
            sleep 2
            check_encrypt
        else
            printf "\n[*]\e[0m\e[1;91m Password doesn't match\e[0m\n"
            enter_to_continue
            echo "[*] Refreshing..."
            sleep 0.5
        fi ;;
    [nN]* )
        echo "[*] Process Terminated. Refreshing"
        sleep 0.5
        check_encrypt ;;
    * )
        echo "[*] Process Terminated. Refreshing..."
        sleep 0.5
        check_encrypt
    esac
}

#=======================================================[ Encrytion END ]======================================================

#=======================================================[ Decryption ]==========================================================
check_decrypt () {
    clear
    wdecrypt
    get_service
    
    if [ -f "./Passwords/$keyword.gpg" ]
    then
        decrytion
    elif [[ $keyword == "" ]]
    then
        options
    else
        printf "[*]\e[1;91m Unable to find the service $keyword in Passwords ( Plz Check it manually )\n\e[0m"
        echo -n "[*] Do you want to check the services? [y/N]: "
        read scheck # service check
            case $scheck in
                [yY]* )
                    echo "[*] Moving to Vault.."
                    sleep 2
                    clear
                    list_service;;
                [nN]* )
                    echo "[*] Exiting.."
                    sleep 1
                    options;;
                * )
                    echo "[*] Exiting.."
                    sleep 1
                    options;;
                esac
    fi
}

decrytion () {
    echo "[*] Starting decrytion..."
    sleep 0.6
    printf "[*]\e[0m\e[1;32m Make sure no one is arround you, the password will be shown in plain text\n\e[0m"
    read -r -p "[*] Are you sure you want to view the password? [y/N] " view
    echo ""
    
    case $view in
        [yY]* )    
            cat ./Passwords/$keyword.gpg | gpg --no-symkey-cache > .tmp
            echo -ne "\n[*] Your password for $keyword is: \e[2m" 
            cat .tmp && rm .tmp
            echo -e "\e[0m"
            enter_to_continue
            options ;;
        [nN]* )
            echo "\n[*] Be Safe. BYE =)"
            sleep 2
            options ;;
        * )
            echo "[*] Be Safe. BYE =)"
            sleep 2
            options
        esac
}
#=======================================================[ Decrytion END ]======================================================

#===============================================[ About ]================================================

about() {
    clear
    wabout
    cat about.txt
    enter_to_continue
}

help () {
    clear
    whelp
    cat help.txt
    enter_to_continue
}

options









