# try 1
ffmpeg -loop 1 -i w.png -vframes 901 -vf "fade=out:899:1:alpha=1" -vcodec png -pix_fmt rgba w.mov


# try 2
ffmpeg -loop 1 -i dancing_peaks.gif -vframes 901 -vf "fade=out:899:1:alpha=1" -vcodec png -pix_fmt rgba w.mov
ffmpeg -i movie.mov -acodec copy -vf "movie=w.mov [logo]; [in][logo] overlay=10:main_h-overlay_h-10 [out]" w_movie.mov


# # try 3
# ffmpeg -i input.mpg -vf "movie=wm.png [watermark];[in][watermark] scale=120:120,overlay=10:10 [out]" output/test.mpg
# movie=wm.png, scale=120:120 [watermark]; [in][watermark] overlay=10:10 [out]
# ffmpeg -i input.mpg -vf "movie=wm.png [watermark];[in][watermark] scale=120:120,overlay=10:10 [out]" output/test.mpg

# try 3 mod...
ffmpeg -i movie.mov -sameq -vf "movie=overlay.png, scale=300:300 [watermark]; [in][watermark] overlay=600:400 [out]" w_movie.mov && open w_movie.mov