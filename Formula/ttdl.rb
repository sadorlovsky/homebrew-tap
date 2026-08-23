# The formula for the Homebrew tap, kept here so it is versioned beside the code it installs. It
# does not live here at install time: the copy brew reads is Formula/ttdl.rb in
# sadorlovsky/homebrew-tap. This one is the source, and the place to make any change other than
# the version — every release copies this file over the tap's, so an edit made there instead
# survives only until the next tag.
#
# url and sha256 are rewritten in the tap by the release workflow, not here, because the checksum
# is of a tarball GitHub generates on request and so cannot exist before the tag does. By hand:
#
#   curl -sL https://github.com/sadorlovsky/ttdl/archive/refs/tags/v0.1.0.tar.gz | shasum -a 256
#
class Ttdl < Formula
  include Language::Python::Virtualenv

  desc "Archive a whole TikTok account: videos, photo carousels, metadata, thumbnails"
  homepage "https://ttdl.orlovsky.dev"
  url "https://github.com/sadorlovsky/ttdl/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "7ee98bc5485056b493cb212ff3655daaf9bc6d1b18cc52007b098b76e46815b8"
  license "MIT"
  head "https://github.com/sadorlovsky/ttdl.git", branch: "main"

  # yt-dlp is the extractor and is not optional. ffmpeg is needed by a default run, which
  # measures loudness; --no-loudness is the only way around it. rclone is deliberately absent:
  # only push and check --remote want it, and most archives never leave the machine.
  depends_on "ffmpeg"
  depends_on "python@3.13"
  depends_on "yt-dlp"

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      Storage commands need rclone, which is not a dependency:
        brew install rclone

      Shell completion:
        ttdl completion zsh > "$(brew --prefix)/share/zsh/site-functions/_ttdl"

      `ttdl doctor` checks the rest.
    EOS
  end

  test do
    assert_match "ttdl #{version}", shell_output("#{bin}/ttdl --version")
    assert_match "COMMAND", shell_output("#{bin}/ttdl --help")
  end
end
