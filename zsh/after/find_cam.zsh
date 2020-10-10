export EXT_WEBCAM=$(system_profiler SPCameraDataType | grep Live\ Streamer | sed 's/://' | sed 's/    //')
