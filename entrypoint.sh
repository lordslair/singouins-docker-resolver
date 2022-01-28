#!/bin/sh
OK="\t[\e[92m✓\e[0m]"
KO="\t[\e[91m✗\e[0m]"

echo "path:$APP_PATH"
echo "quiet:$QUIET"
echo "repo:$GIT_REPO"
echo "env:$NODE_ENV"
echo '-----'

if [ ! -d $APP_PATH ]
then
    echo -n `date +"%F %X"` "Cloning"
    mkdir $APP_PATH
    if [ $QUIET='True' ]
        then
            cd $APP_PATH && git clone --quiet https://"$GIT_USER":"$GIT_TOKEN"@github.com/"$GIT_REPO".git . >/dev/null 2>&1
        else
            cd $APP_PATH && git clone https://"$GIT_USER":"$GIT_TOKEN"@github.com/"$GIT_REPO".git .
    fi

    if [ $? -eq 0 ]
    then
        echo -e $OK
    else
        echo -e $KO
    fi
fi

echo -n `date +"%F %X"` "Installing dependancies"
if [ $QUIET='True' ]
    then
        npm install --silent >/dev/null 2>&1
    else
        npm install
fi
if [ $? -eq 0 ]
then
    echo -e $OK
else
    echo -e $KO
fi

echo `date +"%F %X"` "We're done"
echo `date +"%F %X"` "Starting APP"
cd $APP_PATH && npm run start
