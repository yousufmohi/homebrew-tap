class Meiose < Formula
  desc "An MCP proxy that trims oversized tool outputs before they reach your agent"
  homepage "https://github.com/yousufmohi/meiose"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.2.0/meiose-aarch64-apple-darwin.tar.xz"
      sha256 "5d462f789e29f679b9f3bc8d8003a5be84ad83525136603fd0011a4679f28bd7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.2.0/meiose-x86_64-apple-darwin.tar.xz"
      sha256 "b7e65512a4deed45ce2e5f77c3d5a3db5df4cee8a4ff7b6d602739b51417f6dc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.2.0/meiose-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7af99ec2dbbc74c2dbdfcb6267ae82ed6b8ef45cac0d2d1d69837b76303a1497"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.2.0/meiose-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2d26ee0c1e9e0eb1aee89e6c3da0e0abd7778ddb20865cf7833afbcab231842c"
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
