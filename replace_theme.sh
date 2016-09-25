#!/bin/bash
epoch=$(date +'%s')

resource=gnome-shell-theme.gresource
currentpath=current/theme/
resourcexml=${resource}.xml

rm -f ${currentpath}${resourcexml}
rm -f ${currentpath}${resource}
files=$(for i in ${currentpath}*; do f=$(basename $i); echo "<file>$f</file>"; done)

output=$(cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<gresources>
  <gresource prefix="/org/gnome/shell/theme">
  $files
  </gresource>
</gresources>
EOF
)

echo "$output" > ${currentpath}${resourcexml}
cwd=$(pwd)
cd ${currentpath} 
glib-compile-resources ${resourcexml}
cd ${cwd}
if [ ! -d backup ]; then
  mkdir -p backup
fi
cp /usr/share/gnome-shell/${resource} backup/${resource}.${epoch}
sudo cp ${currentpath}${resource}  /usr/share/gnome-shell/
