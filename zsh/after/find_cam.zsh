findcam=$(system_profiler SPCameraDataType | grep Live\ Streamer | sed 's/://' | sed 's/    //')
webcam="${findcam:-FaceTime HD Camera (Built-in)}"
export WEBCAM=$webcam
export LOLCOMMITS_DEVICE=$webcam
