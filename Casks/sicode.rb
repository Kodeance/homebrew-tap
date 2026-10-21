cask "sicode" do
  version "0.9.7"
  sha256 "b7c098da3585e2620c96f98ea8c5008764d5e9f3a50f770eea2dff667a585412"

  url "https://github.com/Kodeance/sicode-releases/releases/download/v#{version}/Sicode-#{version}.dmg"
  name "Sicode"
  desc "Worktree terminal for coding agents"
  homepage "https://github.com/Kodeance/sicode-releases"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Sicode.app"
  binary "#{appdir}/Sicode.app/Contents/Resources/bin/sicode"

  zap trash: [
    "~/.sicode",
    "~/Library/Application Support/app.sicode",
    "~/Library/Caches/app.sicode",
    "~/Library/HTTPStorages/app.sicode",
    "~/Library/Preferences/app.sicode.plist",
    "~/Library/Saved Application State/app.sicode.savedState",
  ]

  caveats <<~EOS
    Sicode isn't notarized by Apple. If macOS blocks the first launch, open
    System Settings → Privacy & Security and click "Open Anyway".
    Sicode updates itself after that.
  EOS
end
