class Grove < Formula
  desc "Create and jump between git worktrees from the terminal"
  homepage "https://github.com/genesisdayrit/grove"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genesisdayrit/grove/releases/download/v0.1.2/grove-aarch64-apple-darwin.tar.xz"
      sha256 "65c003fa3345e2ab934a86bd2301f8d2dae9452f07956747b48fb21038ceba9c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/genesisdayrit/grove/releases/download/v0.1.2/grove-x86_64-apple-darwin.tar.xz"
      sha256 "27bb02758ec92cef29ecc76544b5429276536fbeb825f54587a8354a80ca0d2f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genesisdayrit/grove/releases/download/v0.1.2/grove-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2a89282a4df828b079d5d7774828faf32590f8fc31b4fdb80ac452d8c01117b0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/genesisdayrit/grove/releases/download/v0.1.2/grove-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6f07c3becc2a0075719518d9db3d92a016a19c5fcbe257fea389284484333bcb"
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
