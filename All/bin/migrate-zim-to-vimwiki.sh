# This script copies all Zim calendar date pages to vimwiki diary pages
# does not transfer subpages or images, just YYYY/MM/DD.txt files
# to zimwiki's YYYY-MM-DD.wiki filename format
ZIM_CALENDAR_DIR="$HOME/Dropbox/Notebooks/Notes/Calendar"
VIMWIKI_DIARY_DIR="$HOME/Dropbox/vimwiki/journal"

for year in $(ls $ZIM_CALENDAR_DIR); do
	for month in $(ls $ZIM_CALENDAR_DIR/$year); do
		for day_file in $(ls $ZIM_CALENDAR_DIR/$year/$month/); do
			day=$(echo $day_file | sed "s/\([0-9]\)\([0-9]\).txt/\1\2/")
			cp $ZIM_CALENDAR_DIR/$year/$month/$day_file $VIMWIKI_DIARY_DIR/$year-$month-$day.wiki
		done
	done
done
