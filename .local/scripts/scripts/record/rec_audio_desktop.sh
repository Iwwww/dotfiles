audio_device="alsa_output.pci-0000_05_00.6.analog-stereo.monitor"
output_dir="/home/mikhail/Music/records/"
mkdir -p "$output_dir"
output_file="$output_dir$1"
echo $output_file

ffmpeg -f pulse -ac 2 -ar 48000 -i $audio_device -acodec mp3 -ar 44100 -b:a 192k -ac 2 $output_file
