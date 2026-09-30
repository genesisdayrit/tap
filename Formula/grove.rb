class Grove < Formula
  desc "Create and jump between git worktrees from the terminal"
  homepage "https://github.com/genesisdayrit/grove"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genesisdayrit/grove/releases/download/v0.1.1/grove-aarch64-apple-darwin.tar.xz"
      sha256 "d7952d3c5827a1b2740999d1d356a0018cd5cd886be816e43451fbb296652277"
    end
    if Hardware::CPU.intel?
      url "https://github.com/genesisdayrit/grove/releases/download/v0.1.1/grove-x86_64-apple-darwin.tar.xz"
      sha256 "66d6f0adc51a5fed5a2cd0ff80b129cc0ea1ba19b72d304bff8ec24085c3a136"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genesisdayrit/grove/releases/download/v0.1.1/grove-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4ea59bd18f3a399262191b938845acebe3bc6cb880fa52e9a205ae823e0edf06"
    end
    if Hardware::CPU.intel?
      url "https://github.com/genesisdayrit/grove/releases/download/v0.1.1/grove-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ae9b70269d63c8718c223f129a078dcc8de4369a302ccea9bf8ba552832d4f9d"
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
