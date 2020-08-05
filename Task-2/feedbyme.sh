#!/bin/bash

MONGOSHELL='mongodb+srv://cluster0.pn5ss.mongodb.net/feedbyme'

function usage(){
    echo -e "\n
   Usage: ./feedbyme [command]
        
   command
   
   connect   - Establish a connection to database.
   login     - Login as a user. Needs connection to database.
   logout    - Logout from current user session.
   register  - Register as a new user.
   hellofile - Open up the local hello file.  
    \n" 
}

function login(){
    read -p "Enter username: " USERNAME
    read -p "Enter password: " PASSWORD
    
    QUERY="db.userData.findOne({'username':'${USERNAME}', 'password':'${PASSWORD}'})" 
    RES=$( mongoshell/bin/mongo "$MONGOSHELL" -u feedbyme -p feedbyme --quiet --eval "$QUERY" )

    echo -e "\nServer output: $RES\n"    
    
    if [ -z "$RES" ]; then
        echo "Invalid username or password. Try again!"
    else
        set MONGOUSER="$USERNAME"
        set MONGOPASS="$PASSWORD"

        echo -e "Successfully logged in!\n"
    fi
}

function logout(){
    unset MONGOUSER
    unset MONGOPASS

    echo -e "\nLogged out successfully!\n"
}

function register(){
    read -p "Enter username: " USERNAME
    read -p "Enter password: " PASSWORD
    
    QUERY="db.userData.insert({'username':'${USERNAME}', 'password':'${PASSWORD}'})" 
    mongoshell/bin/mongo "$MONGOSHELL" -u feedbyme -p feedbyme --quiet --eval "$QUERY" &> /dev/null

    set MONGOUSER="$USERNAME"
    set MONGOPASS="$PASSWORD"

    echo -e "\nSuccessfully registered!\n"
    hellofile
}

function hellofile(){ 
    echo -e "\nOpening hellofile.txt...\n"
    vi hellofile.txt
}

function connect(){ 
    if ! command -v "./mongoshell/bin/mongo" &> /dev/null; then
    echo -e "\nConnection request failed!\n"
        echo -e "Reason: Mongo is not installed on your system!\n"
    else
        echo -e "\nConnection to database successful!\n"
    fi
}

if [ $# = 0 ]; then
    usage
elif [ $1 = "login" ]; then
    login
elif [ $1 = "logout" ]; then
    logout
elif [ $1 = "register" ]; then
    register
elif [ $1 = "hellofile" ]; then
    hellofile
elif [ $1 = "connect" ]; then
    connect
else
    echo -e "\nInvalid Argument!"
    usage 
fi
