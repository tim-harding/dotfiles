function dslr_webcam
    sudo modprobe v4l2loopback

    v4l2-ctl --list-devices \
        | string join '' \
        | string match \
        --regex \
        --groups-only \
        "v4l2loopback-\d+\):\s(/dev/video\d+)" \
        | read -l cam

    gphoto2 --stdout autofocusdrive=1 --capture-movie \
        | ffmpeg -i - \
        -vcodec rawvideo \
        -pix_fmt yuv420p \
        -threads 0 \
        -f v4l2 \
        $cam
end
