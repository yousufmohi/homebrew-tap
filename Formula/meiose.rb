class Meiose < Formula
  desc "An MCP proxy that trims oversized tool outputs before they reach your agent"
  homepage "https://github.com/yousufmohi/meiose"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.2.2/meiose-aarch64-apple-darwin.tar.xz"
      sha256 "01c9ec65f99c40836af946741152decee38b0960f294129dc0327e3883204f0a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.2.2/meiose-x86_64-apple-darwin.tar.xz"
      sha256 "baa9aaac60b5ab21a9ed9a3bf9478391ce968f4b42b00a4ec96ce09880589e42"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.2.2/meiose-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2685335aba55224ee39f0c296c7c0f9036fdf5a32c7f3feff10809dc57ce7bdf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yousufmohi/meiose/releases/download/v0.2.2/meiose-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bd5d84cc282eb77a87dcc00cc5b594c5c7ffd6f3ac16e76c1387d28c690e1855"
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
