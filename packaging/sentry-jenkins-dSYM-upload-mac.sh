#!/bin/sh

IFS=,
osgLibs="osg,osgDB,osgUtil,osgViewer,osgParticle,osgFX,osgGA,osgText,osgSim"
osgPlugins="ac,osg,freetype,imageio,rgb,txf,mdl,3ds,dds"
suffix=

DWARF_DSYM_FOLDER_PATH=$WORKSPACE/dist/symbols

# create output dir
mkdir -p $DWARF_DSYM_FOLDER_PATH
# erase the contents
rm -rf $DWARF_DSYM_FOLDER_PATH/*


for lib in $osgLibs
do
    libPath=$WORKSPACE/dist/lib/lib${lib}${suffix}.dylib
    symPath=$DWARF_DSYM_FOLDER_PATH/$lib.dSYM
    dsymutil -o $symPath $libPath
done

for plugin in $osgPlugins
do
    libPath=$WORKSPACE/dist/lib/osgPlugins/osgdb_${plugin}${suffix}.dylib
    symPath=$DWARF_DSYM_FOLDER_PATH/osgdb_$plugin.dSYM
    dsymutil -o $symPath $libPath
done

dsymutil -o $DWARF_DSYM_FOLDER_PATH/libOpenThreads.dSYM $WORKSPACE/dist/lib/libOpenThreads${suffix}.dylib

if which sentry-cli >/dev/null; then
    export SENTRY_ORG=flightgear
    export SENTRY_PROJECT=flightgear
  #  export SENTRY_AUTH_TOKEN=YOUR_AUTH_TOKEN
    ERROR=$(sentry-cli upload-dif "$DWARF_DSYM_FOLDER_PATH" 2>&1 >/dev/null)
    if [ ! $? -eq 0 ]; then
        echo "warning: sentry-cli - $ERROR"
    fi
else
    echo "warning: sentry-cli not installed, download from https://github.com/getsentry/sentry-cli/releases"
fi