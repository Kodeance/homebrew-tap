cask "monnercode" do
  version "0.10.0"
  sha256 "8f4435aefc59e09abd58d4ff0b6f58481ca29ec46b0098f8e10ee0edfbd9b5ef"

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

  zap trash: [
    "~/.monnercode",
    "~/Library/Application Support/app.monnercode",
    "~/Library/Caches/app.monnercode",
    "~/Library/HTTPStorages/app.monnercode",
    "~/Library/Preferences/app.monnercode.plist",
    "~/Library/Saved Application State/app.monnercode.savedState",
  ]

  caveats <<~EOS
    Monnercode isn't notarized by Apple. If macOS blocks the first launch, open
    System Settings → Privacy & Security and click "Open Anyway".
    Monnercode updates itself after that.
  EOS
end
