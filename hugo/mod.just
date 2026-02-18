set quiet := true
set shell := ['bash', '-euo', 'pipefail', '-c']

hugo_dir := justfile_dir() + '/hugo'

[private]
default:
  just -l hugo

[doc('Run preview')]
run:
  hugo server -D --disableFastRender

[doc('New post')]
post title:
  hugo new blog/{{ title }}
