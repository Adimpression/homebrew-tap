class DotdiwTrackerJira < Formula
  desc "Jira Cloud tracker adapter for dotdiw"
  homepage "https://github.com/Adimpression/dotdiw"
  url "https://github.com/Adimpression/dotdiw/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "4e90160efbbf7307ee8a9972df849dec600e621b2ccbfe8b8e0b3e2ca8ceb8c2"
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
