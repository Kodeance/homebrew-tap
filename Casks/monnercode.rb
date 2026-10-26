cask "monnercode" do
  version "0.14.0"
  sha256 "0ba5783af2bae8b26ff2a09a5a88063d0e5d83a1a5c4f448036decde460f9665"

  url "https://github.com/Kodeance/monnercode-releases/releases/download/v#{version}/Monnercode-#{version}.dmg"
  name "Monnercode"
  desc "Worktree terminal for coding agents"
  homepage "https://github.com/Kodeance/monnercode-releases"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Monnercode.app"
  binary "#{appdir}/Monnercode.app/Contents/Resources/bin/monnercode"

  preflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "Monnercode.app"], chdir: "."
  end

  zap trash: [
    "~/.monnercode",
    "~/Library/Application Support/app.monnercode",
    "~/Library/Caches/app.monnercode",
    "~/Library/HTTPStorages/app.monnercode",
    "~/Library/Preferences/app.monnercode.plist",
    "~/Library/Saved Application State/app.monnercode.savedState",
  ]

  caveats <<~EOS
    Monnercode isn't notarized by Apple, so this cask clears the download's
    quarantine flag: macOS opens it without asking. It updates itself after that.
  EOS
end
