class Meiose < Formula
  desc "A context-trimming proxy for MCP servers: smaller tool outputs for AI agents, originals one call away"
  homepage "https://github.com/yousufmohi/meiose"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.1.0/meiose-aarch64-apple-darwin.tar.xz"
      sha256 "500f1cda61209d7375a9d1a6acb24341d519315fce7b55bce75dcfac4d29e6ff"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.1.0/meiose-x86_64-apple-darwin.tar.xz"
      sha256 "6cfaffbebf79ff9f272ac77212e4737d1bf59d6dc35e51059262634989afddee"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.1.0/meiose-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5bdae9c2739c41cb408a6494ddfb8fdab092b40244a4bff6834c9cf1ae1e51c6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.1.0/meiose-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f2b1bb0ca3e5cdf2eac5c29ce2a84e67e61cada8036233a798c8b502024cdb5c"
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
