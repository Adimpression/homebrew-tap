class Dotdiw < Formula
  include Language::Python::Shebang

  desc "Workflow discovery: the procedure that applies surfaces when work starts"
  homepage "https://github.com/Adimpression/dotdiw"
  # Verified 2026-11-13 from this working copy: the sha256 was computed from
  # the downloaded tag tarball, brew fetched it against that sum, `brew test`
  # passed, the shebang was rewritten to the keg's python@3.12, and the keg's
  # dotdiw, with no bd on its PATH, adopted a throwaway repository on a fresh
  # HOME: the key in its .git/config, the tracker under ~/.dotdiw, nothing of
  # the tracker's in the tree, and `--version` naming the tracker with its
  # number. Through the keg, a claimed step's values were recorded and read
  # back on the local store and on a stub of Jira.
  url "https://github.com/Adimpression/dotdiw/archive/refs/tags/v4.0.0.tar.gz"
  sha256 "f7f5f0e9895010dc94736c149561ae5a83543294957f192b090618f0f886644a"
  license "Apache-2.0"
  head "https://github.com/Adimpression/dotdiw.git", branch: "main"

  # Day 0 installs what dotdiw depends on. A prerequisite the newcomer installs
  # themselves is a per-project step in disguise.
  depends_on "git"
  depends_on "python@3.12"

  def install
    bin.install "dotdiw"
    rewrite_shebang detected_python_shebang, bin/"dotdiw"
  end

  test do
    # Its own version, not that of the tool it wraps.
    assert_match "dotdiw #{version}", shell_output("#{bin}/dotdiw --version")

    # Reachable, and teaches without a project.
    assert_match "MANAGEMENT", shell_output("#{bin}/dotdiw learn")

    # Knows nothing about any project: it reads whichever one it is run in.
    system "git", "init", testpath/"repo"
    assert_match "No formulas yet", shell_output("cd #{testpath}/repo && #{bin}/dotdiw check")
  end
end
