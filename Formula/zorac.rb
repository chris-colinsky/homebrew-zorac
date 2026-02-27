class Zorac < Formula
  desc "Self-hosted local LLM chat client for vLLM inference servers"
  homepage "https://github.com/chris-colinsky/zorac"
  url "https://files.pythonhosted.org/packages/0b/a8/e051b2bcab4f227d885350378caf071ade08572ff844428d9eb03a51b758/zorac-1.4.1.tar.gz"
  sha256 "a03e4c175d5b94718446536a546544c9debf30348767c9ecfc6cd41fa8510122"
  license "MIT"

  bottle do
    rebuild 1
    root_url "https://github.com/chris-colinsky/homebrew-zorac/releases/download/zorac-1.4.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4143fc8302f4f435bd110a08f87859443af6105b8f9a9b8dbe4ac76282796ab6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6d1fea1e19d2e053e2c7e52656a1f5ff0ef4840383b462c26f2a94048eb322df"
  end

  depends_on "python@3.13"
  depends_on "rust" => :build

  skip_clean "libexec"

  def install
    python = Formula["python@3.13"].opt_bin/"python3.13"

    # Several Rust extension wheels (jiter, pydantic-core, tiktoken) ship without
    # -headerpad_max_install_names, so Homebrew's post-install relocation step
    # fails trying to rewrite their @rpath dylib IDs to long absolute paths.
    # Building them from source with this linker flag resolves the issue.
    ENV.append "RUSTFLAGS", "-C link-arg=-headerpad_max_install_names"

    system python, "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    system libexec/"bin/pip", "install",
           "--no-binary", "jiter,pydantic-core,tiktoken",
           "zorac==1.4.1"

    (bin/"zorac").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/bin/zorac" "$@"
    EOS
  end

  test do
    assert_match "zorac", shell_output("#{bin}/zorac --help")
  end
end
