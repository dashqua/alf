#/bin/sh

INRES=$(echo $(xrandr | grep '*' | head -n1) | cut -d " " -f1)    #"1280x720" # input resolution
OUTRES="1920x1080" # output resolution
FPS="24" # target FPS
GOP="48" # i-frame interval, should be double of FPS, 
GOPMIN="15" # min i-frame interval, should be equal to fps, 
THREADS="0" # max 6
CBR="1M" # constant bitrate (should be between 1000k - 3000k)
QUALITY="ultrafast"  # one of the many FFMPEG preset
AUDIO_RATE="44100"
STREAM_KEY=$(cat twitch_key)    #"$1" # use the terminal command Streaming streamkeyhere to stream your video to twitch or justin
SERVER="live-ams" # twitch server in frankfurt, see http://bashtech.net/twitch/ingest.php for list
BUF="2M"

# deprec="-thread_queue_size 256  "
#        -vf fps=$FPS
#        -x264-params "nal-hrd=cbr" -b:v $CBR -minrate $CBR -maxrate $CBR -bufsize $BUF -pix_fmt yuv420p\
#        -preset $QUALITY -tune film   -strict normal \
#       -vf mpdecimate   
#          -f alsa -i pulse   -vcodec libx264

./ffmpeg-4.1/ffmpeg_g  \
    -f x11grab -s $INRES -r $FPS -re -i :0.0+0,0 \
    -ac 2  -s $OUTRES \
    -acodec libmp3lame -ab 128k -ar $AUDIO_RATE -threads $THREADS\
    -f flv "rtmp://$SERVER.twitch.tv/app/$STREAM_KEY"  \
    -g $GOP -keyint_min $GOPMIN 
 
