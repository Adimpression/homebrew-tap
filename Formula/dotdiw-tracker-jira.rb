class DotdiwTrackerJira < Formula
  desc "Jira Cloud tracker adapter for dotdiw"
  homepage "https://github.com/Adimpression/dotdiw"
  url "https://github.com/Adimpression/dotdiw/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "0e5c5a227728aa8795e3f379b5a2a5c81e9d56869569346a8a4560e1c910b86f"
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
