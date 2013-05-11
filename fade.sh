rm -f tfifo
rm -f overlay.rgba
mkfifo tfifo
convert overlay.png overlay.rgba

(
  alpha=-255
  fade=20
  while [[ $alpha -le 0 ]]
  do
    (echo "RGBA32 200 200 0 0 $alpha 1"; cat overlay.rgba) >tfifo
    sleep 0.1
    let t=alpha+fade
    if [[ $alpha -ne 0  &&  $t -gt 0 ]]; then t=0; fi
    alpha=$t
  done
  sleep 0.5
  while [[ $alpha -ge -255 ]]
  do
    (echo "RGBA32 200 200 0 0 $alpha 1"; cat overlay.rgba) >tfifo
    sleep 0.1
    let t=alpha-fade
    if [[ $alpha -ne 0  &&  $t -le -255 ]]; then t=-255; fi
    alpha=$t
  done
) &
pid=$!

# mplayer -vf bmovl=0:0:tfifo movie.mov
mencoder -oac pcm -ovc raw -vf bmovl=0:0:tfifo -o w_movie.mov movie.mov


rm -f tfifo
rm -f overlay.rgba
if kill -0 $pid; then kill -9 $pid; fi

