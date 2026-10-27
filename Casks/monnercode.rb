cask "monnercode" do
  version "0.16.0"
  sha256 "1f482fc937b4a147b9aad563e7c17614f789d1f9078bd7b2bdc3a33c737e4dca"

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
