cask "sicode" do
  version "0.9.2"
  sha256 "09ae62789810e788b45ab834ea010e558326b6689ae13f315e70fb0a2e5cc0d4"

  url "https://github.com/JonasDPDK/sicode-releases/releases/download/v#{version}/Sicode-#{version}.dmg"
  name "Sicode"
  desc "Worktree terminal for coding agents"
  homepage "https://github.com/JonasDPDK/sicode-releases"

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
