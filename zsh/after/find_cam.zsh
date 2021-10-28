# webcam=$(system_profiler SPCameraDataType | grep Live\ Streamer | sed 's/://' | sed 's/    //')
webcam=$(system_profiler SPCameraDataType | grep Logitech\ Webcam\ C930e | sed 's/://' | sed 's/    //')

delay=0

if [ -z "$webcam" ]; then
  webcam="FaceTime HD Camera (Built-in)"
  delay=2
fi
export WEBCAM=$webcam
export LOL_DELAY=$delay
export LOLCOMMITS_DEVICE=$webcam
