#!/usr/bin/env python3

import os
import sys
import requests
import subprocess

from glob import glob

token = os.getenv('GITHUB_API_TOKEN')
if not token:
    print("No API token found in environment", file=sys.stderr)
    exit(1)

release_tag = os.getenv('TAG_NAME')
if not release_tag:
    print("No tag found in environment", file=sys.stderr)
    exit(1)

print(f"# Current tag is {release_tag}")

base_headers = {
    'Accept': 'application/vnd.github.v3+json',
    'Authorization': f"token {token}",
}

url = 'https://api.github.com/repos/IBM/xmlservice/tags'
headers = base_headers
r = requests.get(url)
r.raise_for_status()
tags = r.json()

# Find the tag prior to this one
for i, tag in enumerate(tags):
    if tag['name'] == release_tag:
        prior_tag = tags[i+1]
        break
del tag

commit = prior_tag['commit']['sha']

print(f"# Prior tag is {prior_tag['name']}")

args = [
  'git',
  'log',
  '--grep=Bump version',
  '--invert-grep',
  '--no-merges',
  '--no-decorate',
  '--pretty=format:- %s',
  f"{commit}.."
]

print("# Generating changelog")
r = subprocess.run(args, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)
output = r.stdout.decode('utf-8').rstrip()

body = f"""# XMLSERVICE {release_tag}

## Changes

---

{output}
"""

url = 'https://api.github.com/repos/IBM/xmlservice/releases'

payload = {
    'tag_name': release_tag,
    'name': release_tag,
    'body': body,
    'draft': True
}

headers = base_headers
print(f"# Creating release for {release_tag}")
r = requests.post(url, headers=headers, json=payload)
r.raise_for_status()

release = r.json()
print(f"# Release created: {release['html_url']}")

url = release['upload_url'].split('{')[0]

for name in glob('xmlservice*.savf.xz'):
    print(f"# Uploading {name}")

    params = { 'name': name }
    extra_headers = { 'Content-Type': 'application/x-xz' }
    headers = {**base_headers, **extra_headers}
    r = requests.post(url, headers=headers, params=params, data=open(name, 'rb'))
    r.raise_for_status()


print(f"# Publishing release")
url = release['url']
payload = { 'draft': False }
headers = base_headers
r = requests.patch(url, headers=headers, json=payload)
r.raise_for_status()
release = r.json()
print(f"# Release published at {release['html_url']}")
