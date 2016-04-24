#!/bin/bash
LARNDIR="/usr/games/lib/larn/"
SAVEDIR="$HOME/.larn/save/"
SCOREDIR="$HOME/.larn/score/"
TMPDIR="/tmp/larn"
DATADIR="$TMPDIR/data"
SAVEFILE="$SAVEDIR/savefile.txt"
SCOREFILE="$SCOREDIR/scorefile.txt"
echo "Running wrapper..."
if pgrep "^larn$" >/dev/null
then
  echo "Larn is already running!" 2>&1
  exit 1
fi
mkdir -p $TMPDIR
cp -R $LARNDIR/* $TMPDIR
if [ ! -d "$SAVEDIR" ]; then
	mkdir -p "$SAVEDIR";
fi
if [ -f "$SAVEFILE" ]; then
	mv "$SAVEFILE" $DATADIR;
fi
if [ ! -d "$SCOREDIR" ]; then
	mkdir -p "$SCOREDIR";
fi
if [ -f "$SCOREFILE" ]; then
	mv "$SCOREFILE" $DATADIR/;
fi
cd $TMPDIR
./larn "$@"
if [ -f data/savefile.txt ]; then
	cp data/savefile.txt "$SAVEDIR"
fi
cp data/scorefile.txt "$SCOREDIR"
cd $OLDPWD
rm -rf $TMPDIR
echo "Exiting wrapper..."
