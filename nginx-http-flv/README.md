## FFmpeg + nginx-http-flv-module + flv.js，rtsp转rtmp，直接播放flv格式

将容器运行后使用ffmpeg 推流即可播放

ffmpeg -re -i G:\电影\功夫熊猫_bd.mp4 -c copy -f flv rtmp://192.168.20.2/live/livestream

###播放方式

vlc: rtmp://192.168.20.2/live/livestream

html: http://192.168.20.2/live/livestream.flv