class ClaudePrewarm < Formula
  desc "Keep Claude 5-hour usage windows aligned to your workday"
  homepage "https://github.com/victordesautels/claude-prewarm"
  # Git tag as the source of truth — no sha256 to maintain. Bump `tag` on each
  # release. (Optionally pin `revision: "<full-sha>"` for extra integrity.)
  url "https://github.com/victordesautels/claude-prewarm.git",
      using: :git,
      tag:   "v0.4.2-beta"
  license "MIT"

  depends_on :macos

  def install
    # Support files live under libexec; the CLI is pointed at them via env.
    libexec.install "lib", "assets", "notifier", "scripts"
    libexec.install "bin/claude-prewarm"

    # Build the notifier applet (best-effort; non-fatal if osacompile/codesign
    # are unavailable in the build sandbox — the CLI falls back to a plain
    # osascript notification).
    quiet_system "bash", "#{libexec}/scripts/build-notifier.sh",
                 libexec, "#{libexec}/Claude Prewarm.app"

    # Wrapper on PATH. It points at the STABLE opt_libexec path (not the
    # versioned Cellar path) so the launchd agent the CLI installs keeps
    # resolving after a `brew upgrade`.
    (bin/"claude-prewarm").write_env_script "#{opt_libexec}/claude-prewarm",
      CLAUDE_PREWARM_LIB_DIR:   "#{opt_libexec}/lib",
      CLAUDE_PREWARM_SHARE_DIR: opt_libexec.to_s
  end

  def caveats
    <<~EOS
      Files are installed under the Homebrew prefix. To schedule prewarming,
      run the one-time guided setup:
        claude-prewarm install
      Uninstall the launchd agent(s) before removing the formula:
        claude-prewarm uninstall -y && brew uninstall claude-prewarm
    EOS
  end

  test do
    assert_match "claude-prewarm v", shell_output("#{bin}/claude-prewarm --version")
  end
end
