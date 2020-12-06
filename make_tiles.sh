
#This assumes you have a 5000x4000 pixel image

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
