class Zorac < Formula
  desc "Self-hosted local LLM chat client for vLLM inference servers"
  homepage "https://github.com/chris-colinsky/zorac"
  url "https://files.pythonhosted.org/packages/8d/05/512c4d0d270e615e73336b7acc2ea7afb5adb50a472065e376a1a7117b0b/zorac-1.4.0.tar.gz"
  sha256 "185a8c82ab9776d98cb821f93746765aaee2a5217b36534a83b6c3c968ec245d"
  license "MIT"

  bottle do
    rebuild 2
    root_url "https://github.com/chris-colinsky/homebrew-zorac/releases/download/zorac-1.4.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3df138ebea0d0b22a390bd41654e6de41b8505d043a0ad0f1c26ba44604410e9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5a151146ff4de20a654081f52e32ba34e644ea81f1d0edccab7d61378082a80c"
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
           "zorac==1.4.0"

    (bin/"zorac").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/bin/zorac" "$@"
    EOS
  end

  test do
    assert_match "zorac", shell_output("#{bin}/zorac --help")
  end
end

