#!/usr/bin/env fish

set -l wallpapers \
   "1"   "~/.desktop_backgrounds/idyllic_landscape-wallpaper-5120x1440.jpg" \
   "P"   "~/.desktop_backgrounds/relaxing_views-wallpaper-5120x1440.jpg"

set -l default_wallpaper "~/.desktop_backgrounds/idyllic_landscape-wallpaper-5120x1440.jpg"
set -l workspace "$AEROSPACE_FOCUSED_WORKSPACE"
set -l wallpaper $default_wallpaper

if test -z "$workspace"
    exit 0
end

for i in (seq 1 2 (count $wallpapers))
   if test "$wallpapers[$i]" = "$workspace"
         set wallpaper $wallpapers[(math $i + 1)]
         break
   end
end

osascript -e "
on run argv
   set wp to POSIX file (item 1 of argv)
   tell application \"System Events\"
         tell every desktop
            set picture to wp
         end tell
   end tell
end run
" -- $wallpaper
