class Meiose < Formula
  desc "An MCP proxy that trims oversized tool outputs before they reach your agent"
  homepage "https://github.com/yousufmohi/meiose"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.3.0/meiose-aarch64-apple-darwin.tar.xz"
      sha256 "73570020e473ed0e724b81718647f8cb25dc959669c9c3c3b6f6f99c9dc2ce8e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.3.0/meiose-x86_64-apple-darwin.tar.xz"
      sha256 "26d66f41aafc00e30373655732f75cda523dc99afe4445401c5529da5f1c157a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.3.0/meiose-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cab3b101fb3d92bf8db28d0930a9cd9541f3706e5e16bfd29c337c1bf7741e69"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.3.0/meiose-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e4c5b301f98399dd7fbeda51aa335cce50c92b1009d8c3c5eff9204ac5e23d49"
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
