class DotdiwTrackerJira < Formula
  desc "Jira Cloud tracker adapter for dotdiw"
  homepage "https://github.com/Adimpression/dotdiw"
  url "https://github.com/Adimpression/dotdiw/archive/refs/tags/v3.0.0.tar.gz"
  sha256 "39a5b42ff9d056306b9e7bd977fde57c475663d52db9161fc6ebdebd9e9b177e"
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
