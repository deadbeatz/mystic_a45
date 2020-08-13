p '' 2
# $1 Node number
# $2 Door Call Name
# $3 Doorfile type :1 DOOR.SYS :2 CHAIN.TXT
stty cols 80 rows 25
MYNAME=$(sed -n '36p' /mystic/temp$1/DOOR.SYS)

BBSROOT=/mystic
NODE=$BBSROOT/temp$1
#EXTNODE=/opt/share/node$1
# Convert DOOR.SYS to DOS line endings
unix2dos $NODE/DOOR.SYS 2>/dev/null

# Define root directory for DOSEMU hdd
DROOT=/home/<USERHERE>/.dosemu/drive_c/nodes/temp$1

# Define node directory inside DOSEMU filesystem
cp $NODE/DOOR.SYS $DROOT/DOOR.SYS
#cp $NODE/DOOR.SYS $EXTNODE

# Generate a random lowercase 4 digit code for batch file uniqueness
RAND= tr -dc a-f0-9 2>/dev/null  </dev/urandom | head -c 4 1>/dev/null 

FILE=RUN$RAND.BAT

# Convert to lowercase for linux
DOOR=$(echo "$2" | tr '[:upper:]' '[:lower:]')

run_batch(){
    # Arg 1 = NODE
    # Arg 2 = FILE (batch filename)
    # Arg 3 = DROOT (dosemu node folder)
    /usr/bin/dosemu -E "C:\\NODES\\TEMP$1\\$2" 1>/dev/null 2>&1
    rm $3/$2
    rm $3/DOOR.SYS
}

case "$DOOR" in
    dark)
        echo -e '\r@echo off \r' > $DROOT/$FILE
        echo -e 'c: \r' >> $DROOT/$FILE
        echo -e 'cd c:\\doors\\darkness\\ \r' >> $DROOT/$FILE
        echo -e 'dark16 /n'$1' \r' >> $DROOT/$FILE
        echo -e 'c:\\sleep 3 \r' >> $DROOT/$FILE
        echo -e 'exitemu' >> $DROOT/$FILE
        unix2dos $DROOT/$FILE 2>/dev/null
        run_batch $1 $FILE $DROOT
        ;;

    *)
        echo "Invalid option"
        ;;
esac
trap 2
