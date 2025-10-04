from pathlib import Path
import requests
from os import environ as env
import subprocess

def run(*args, **kwargs):
    print(f"$ {' '.join(args)}")
    subprocess.run(args, check=True, **kwargs)
    

MAVKIT_REPO_URL = 'https://github.com/mavryk-network/mavryk-packaging/releases/latest'


def main():
    version_file = Path('mavkit_version')
    current_version = version_file.read_text().strip() if version_file.exists() else ''
    print(f'Current version: {current_version}')
    latest_version = requests.get(MAVKIT_REPO_URL).url.split("/")[-1]
    print(f'Latest version:  {latest_version}')

    if current_version == latest_version:
        print('Mavkit version is up to date.')
        exit(0)

    if not env.get("GITHUB_ACTIONS"):
        print("This script is intended to be run in a GitHub Action.")
        exit(0)

    print('Mavkit version has changed. Updating...')
    Path('mavkit_version').write_text(latest_version)
    exit(1)

if __name__ == "__main__":
    main()