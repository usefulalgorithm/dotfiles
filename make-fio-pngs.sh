#!/bin/bash

#  Usage:
#  Suppose your directory looks like this:
#
#  (work directory)
#  --> (log directory) => Containing fio log files
#  --> (png directory) => Destination for the .png files
#  --> other irrelevant stuff...
#
#  Then run this program like:
#
#      ./make-fio-pngs.sh (log directory) (png directory)
#
#
#  Note that your log directory should NOT contain any white space.
#  If you want to generate pngs for multiple log directories, do:
#
#      for $i in `echo log directories`; do ./make-fio-pngs.sh $i (png directory); done
#
#
#  You can also create custom names (that contain white spaces) for your pngs:
#
#      ./make-fio-pngs.sh (log directory) (png directory) (a nice title for your plot)
#
#  The white spaces in your title will get automatically replaced with underscores.


cd $1
if [ -z "$3" ]; then
    fio_generate_plots $1
else
    fio_generate_plots $3
    ls *.svg | while read -r line; do mv "$line" ${line// /_}; done
fi
for i in $(ls *.svg); do
    inkscape -z -e  ${i%.*}.png $i
done
rm -f *.svg
mv *.png ../$2
cd ..
