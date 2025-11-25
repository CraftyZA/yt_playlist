# yt_playlist
Youtube Playlist downloader

## Setup a local virtual environment (.venv)

Windows (PowerShell):
- Right-click setup_venv.ps1 and choose "Run with PowerShell"; or run:
  powershell -ExecutionPolicy Bypass -File .\setup_venv.ps1
- Activate it for the current shell:
  .\.venv\Scripts\Activate.ps1

macOS/Linux (manual):
- python3 -m venv .venv
- source .venv/bin/activate
- pip install -r requirements.txt

## Run
With the virtual environment activated:

python main.py -p <playlist_url> -d <output_directory> [-s <itag>]

See stream_audio.md for common audio stream itags.
