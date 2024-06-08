import argparse
import re
from pytube import Playlist
from pytube.exceptions import PytubeError

arg_parser = argparse.ArgumentParser()
arg_parser.add_argument("-p", "--playlist", required=True, help="Youtube Music Playlist URL")
arg_parser.add_argument("-d", "--directory", required=True, help="Destination directory to save output")
arg_parser.add_argument("-s", "--stream", required=False, help="Youtube Stream Audio", default="140")
args = vars(arg_parser.parse_args())

playlist = Playlist(args['playlist'])
youtube_stream_audio = args['stream']
directory = args['directory']

playlist._video_regex = re.compile(r"\"url\":\"(/watch\?v=[\w-]*)")

print(f"Downloading " + str(len(playlist.video_urls)) + " files.")
for video in playlist.videos:
    try:
        print("Getting " + video.title + " ...")
        audioStream = video.streams.get_by_itag(youtube_stream_audio)
        if audioStream:
            audioStream.download(output_path=directory)
            print(f"Downloaded: {video.title}")
        else:
            print(f"Stream with itag {youtube_stream_audio} not found for video: {video.title}")
    except PytubeError as e:
        print(f"Failed to download {video.title}: {str(e)}")
    except Exception as e:
        print(f"An unexpected error occurred with video {video.title}: {str(e)}")

