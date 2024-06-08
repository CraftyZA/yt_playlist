import argparse
import re
from pytube import Playlist

arg_parser = argparse.ArgumentParser()
arg_parser.add_argument("-p", "--playlist", required=True, help="Youtube Music Playlist URL")
arg_parser.add_argument("-d", "--directory", required=True, help="Destination directory to save output")
arg_parser.add_argument("-s", "--stream", required=False, help="Youtube Stream Audio", default="140")
args = vars(arg_parser.parse_args())

playlist = Playlist(args['playlist'])
youtube_stream_audio = args['stream']
directory = args['directory']

playlist._video_regex = re.compile(r"\"url\":\"(/watch\?v=[\w-]*)")

print("Downloading " + str(len(playlist.video_urls)) + " files.")
for video in playlist.videos:
    print("Getting " + video.title + " ...")
    audioStream = video.streams.get_by_itag(youtube_stream_audio)
    audioStream.download(output_path=directory)

