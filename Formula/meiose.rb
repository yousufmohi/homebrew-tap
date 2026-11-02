class Meiose < Formula
  desc "An MCP proxy that trims oversized tool outputs before they reach your agent"
  homepage "https://github.com/yousufmohi/meiose"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.2.1/meiose-aarch64-apple-darwin.tar.xz"
      sha256 "4d9cf6a8511f1309f57c59e725416102cdec8e9242da9b90259dd0efd18bbff0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.2.1/meiose-x86_64-apple-darwin.tar.xz"
      sha256 "573d9d19320e1a83768de8ec89dca84f8a93af2bc3bf7c5d00c09dc64aee230b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.2.1/meiose-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "28d242a93581738665c8e93779afadb52dee86a88311bef621391e7931303652"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.2.1/meiose-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e87899f90208a598bc9237b4151bbb073d8144e2fa40946e973a52a08e2494c1"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
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
      bin.install "meiose"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "meiose"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "meiose"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "meiose"
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
