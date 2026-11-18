class DotdiwTrackerJira < Formula
  desc "Jira Cloud tracker adapter for dotdiw"
  homepage "https://github.com/Adimpression/dotdiw"
  url "https://github.com/Adimpression/dotdiw/archive/refs/tags/v4.1.0.tar.gz"
  sha256 "e53f9ff7ccd97d72df14275d42a423928b009edadc7f6ef40baa978685c1b788"
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
