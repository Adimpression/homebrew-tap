class DotdiwTrackerJira < Formula
  desc "Jira Cloud tracker adapter for dotdiw"
  homepage "https://github.com/Adimpression/dotdiw"
  url "https://github.com/Adimpression/dotdiw/archive/refs/tags/v4.2.0.tar.gz"
  sha256 "ca37b18fe2600dc7409572bda788412d7b79b4f93017d4908f1a733740c6591a"
  license "Apache-2.0"

  depends_on "adimpression/tap/dotdiw"

  def install
    (share/"dotdiw/trackers").install "trackers/jira.py"
  end

  test do
    # A tracker over a network cannot reach its service here. Its check runs
    # against a stub in dotdiw's own tests.
    listed = shell_output("dotdiw tracker list")
    assert_match "jira", listed
    refute_match "did not load", listed
  end
end
