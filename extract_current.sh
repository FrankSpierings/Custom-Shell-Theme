#!/bin/sh
#
#https://wiki.archlinux.org/index.php/GDM#Log-in_screen_background_image


workdir=${HOME}/Custom-Shell-Theme/current
if [ ! -d ${workdir}/theme ]; then
  mkdir -p ${workdir}/theme
fi
gst=/usr/share/gnome-shell/gnome-shell-theme.gresource

for r in `gresource list $gst`; do
        gresource extract $gst $r >$workdir/${r#\/org\/gnome\/shell/}
done
