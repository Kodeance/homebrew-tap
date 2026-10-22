cask "monnercode" do
  version "0.11.0"
  sha256 "586a309220c583c1fe7a39e634cc980a7aa7c6077cbb8cc21fff26b439454b1e"

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

  # Monnercode isn't notarized: with the download's quarantine flag, macOS blocks the first launch, and that
  # dialog's "Move to Trash" deletes the app. Cleared on the staged copy, before it's moved to the Applications
  # folder (install steps can't name that folder). Sparkle's updates arrive without the flag.
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
