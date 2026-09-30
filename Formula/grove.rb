class Grove < Formula
  desc "Create and jump between git worktrees from the terminal"
  homepage "https://github.com/genesisdayrit/grove"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genesisdayrit/grove/releases/download/v0.1.0/grove-aarch64-apple-darwin.tar.xz"
      sha256 "a44073b5df760d6c799f184546cb40105e8af8bfe1226b02ecb366bab998712c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/genesisdayrit/grove/releases/download/v0.1.0/grove-x86_64-apple-darwin.tar.xz"
      sha256 "f7fcff0cbd800ea184f1c5f44e70986ca98d4335fc1d881d27f0821a682cb5a1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genesisdayrit/grove/releases/download/v0.1.0/grove-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3011c9713787bfca7c16ec8e2e7e4489cc0bb29e01b64bed7f78650a9feeefc4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/genesisdayrit/grove/releases/download/v0.1.0/grove-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d3e4e2a5e3d1aa454bf14aec0eb5561128396b75b8ab424fca77df36c8595a51"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "grove"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "grove"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "grove"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "grove"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
