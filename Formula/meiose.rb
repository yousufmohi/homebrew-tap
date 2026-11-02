class Meiose < Formula
  desc "A context-trimming proxy for MCP servers: smaller tool outputs for AI agents, originals one call away"
  homepage "https://github.com/yousufmohi/meiose"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.1.1/meiose-aarch64-apple-darwin.tar.xz"
      sha256 "a8c50976022c55daedcbabd3fea3634edf934328fef0d99d0e6f89ba4041349a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.1.1/meiose-x86_64-apple-darwin.tar.xz"
      sha256 "51916bf5630e933de048c5eab651beaec531680e88c49a1bbef5eef4cc9a4be0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.1.1/meiose-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3cacc00ecbdf0554d36b39dda1c2e943c5e4a1d4371480baaf2991bf7e572256"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.1.1/meiose-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e9287b88c2947234b239fe40e268cf7e5bef652fa7ec461eda8441d48e3e7ade"
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
