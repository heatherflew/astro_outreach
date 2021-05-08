#!/bin/bash

#    Copyright (C) 2020-2021 Heather Flewelling

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.


#This assumes you have a 5000x4000 pixel image (in the form of .png), and then converts the image into smaller pngs for zooming. 
#This tool is used to make the zoom tiles to add additional fields into the index.html file.  Essentially, you take an image 
# that is 5000x4000 pixels, like starryfield_r.png, and it will create the appropriate tiles.  You will need to move the tiles to 
# the appropriate directory and edit the index.html yourself. 

file=$1
base=$(basename $file .png)
# zoom 1
echo "zoom 1"
convert $file -resize 500x400 "$base"_zoom_01_00_00.png 


# zoom 2

convert $file -crop 2500x2000 +adjoin test_%02d.png
for i in {00..03}; do
    x=$(echo $i/2 | bc | awk '{printf "%02d", $0}')
    y=$(echo $i%2 | bc | awk '{printf "%02d", $0}')

    convert test_$i.png -resize 500x400 "$base"_zoom_02_"$x"_"$y".png
    echo "zoom 2" $x $y    
done
rm test*

# zoom 3

convert $file -crop 1250x1000 +adjoin test_%02d.png
for i in {00..15}; do
    x=$(echo $i/4 | bc | awk '{printf "%02d", $0}')
    y=$(echo $i%4 | bc | awk '{printf "%02d", $0}')
    convert test_$i.png -resize 500x400 "$base"_zoom_03_"$x"_"$y".png
    echo "zoom 3" $x $y
done
rm test*

# zoom 4

convert $file -crop 625x500 +adjoin test_%02d.png
for i in {00..63}; do
    x=$(echo $i/8 | bc | awk '{printf "%02d", $0}')
    y=$(echo $i%8 | bc | awk '{printf "%02d", $0}')
    convert test_$i.png -resize 500x400 "$base"_zoom_04_"$x"_"$y".png
    echo "zoom 4" $x $y
done
rm test*
