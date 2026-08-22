# homebrew-tap

Homebrew formulae for my own tools.

```bash
brew install sadorlovsky/tap/ttdl
```

## ttdl

[Archive a whole TikTok account](https://github.com/sadorlovsky/ttdl) — videos, photo carousels,
metadata, thumbnails. Documentation is at [ttdl.orlovsky.dev](https://ttdl.orlovsky.dev).

The formula pulls in yt-dlp and ffmpeg, which a default run needs. `rclone` is not a dependency:
only the storage commands want it, and most archives never leave the machine.

`Formula/ttdl.rb` is written by the release workflow in the ttdl repository. Edit
`packaging/ttdl.rb` there instead.
