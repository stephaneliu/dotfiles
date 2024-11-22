function find_cam {
  availableCameras=$(system_profiler SPCameraDataType 2>/dev/null)
  delay=1 # Profiler needs time to think about it

  webcam=$(echo $availableCameras | grep Logitech\ Webcam\ C930e | sed 's/://' | sed 's/    //')
  if [ -z "$webcam" ]; then
    # M4
    webcam=$(echo $availableCameras | grep MacBook\ Pro\ Camera: | sed 's/://')
  elif [ -z "$webcam" ]; then
    # M1
    webcam=$(echo $availableCameras | grep FaceTime HD Camera: | sed 's/://')
  fi

  if [ -z "$webcam" ]; then
    echo "Camera could not be found. Lolcommits will not work correctly"
  fi

  webcam="MacBook Pro Camera"
  export WEBCAM=$webcam
  export LOL_DELAY=$delay
  export LOLCOMMITS_DEVICE=$webcam

  if [ $# -eq 0 ]; then
    echo "Webcam set to $WEBCAM"
  fi
}

find_cam 1
