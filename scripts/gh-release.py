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

tag = os.getenv('TAG_NAME')
if not tag:
    print("No tag found in environment", file=sys.stderr)
    exit(1)

base_headers = {
    'Accept': 'application/vnd.github.v3+json',
    'Authorization': f"token {token}",
}

# r = subprocess.run(['git', 'describe', '--abbrev=0', '--tags', 'HEAD'], stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)
# tag = r.stdout.decode('utf-8').rstrip()
print(f"# Current tag is {tag}")

url = 'https://api.github.com/repos/IBM/xmlservice/tags'
headers = base_headers
r = requests.get(url)
r.raise_for_status()
prior_tag = r.json()[0]
commit = prior_tag['commit']['sha']

# r = subprocess.run(['git', 'describe', '--abbrev=0', '--tags', 'HEAD^'], stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)
# prior_tag = r.stdout.decode('utf-8').rstrip()
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

body = f"""# XMLSERVICE {tag}

## Changes

---

{output}
"""

# print(body)
# exit()


url = 'https://api.github.com/repos/IBM/xmlservice/releases'

payload = {
    'tag_name': '2.0.1', #tag,
    'name': tag,
    'body': body,
    'draft': True
}

headers = base_headers
print(f"# Creating release for {tag}")
r = requests.post(url, headers=headers, json=payload)
r.raise_for_status()

release = r.json()
print(f"# Release created: {release['html_url']}")

url = release['upload_url'].split('{')[0]

#assets = [
#    'xmlservice.savf.xz',
#]

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
# print(r)
