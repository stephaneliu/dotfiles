webcam=$(system_profiler SPCameraDataType | grep Live\ Streamer | sed 's/://' | sed 's/    //') || "FaceTime HD Camera"
export WEBCAM=$webcam
export LOLCOMMITS_DEVICE=$webcam
