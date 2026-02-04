class Zorac < Formula
  desc "Self-hosted local LLM chat client for vLLM inference servers"
  homepage "https://github.com/chris-colinsky/zorac"
  url "https://files.pythonhosted.org/packages/43/ad/2f3316edfb0ca63b9c3bacdaf201ab8adcea4d73847bb118366142b19829/zorac-1.2.0.tar.gz"
  sha256 "a9cc33bcb644ada4fd1a4c799b5fd7062f66d47c0d9880f9aa3770db3b3cfbd5"
  license "MIT"

  depends_on "python@3.13"

  # Skip relinking of native extensions in the venv (jiter, etc.)
  skip_clean "libexec"

  def install
    python = Formula["python@3.13"].opt_bin/"python3.13"

    # Create a virtual environment
    system python, "-m", "venv", libexec

    # Install zorac and all dependencies using pip (will use wheels)
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    system libexec/"bin/pip", "install", "zorac==1.2.0"

    # Create wrapper script that uses the venv
    (bin/"zorac").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/bin/zorac" "$@"
    EOS
  end

  test do
    assert_match "Zorac", shell_output("#{bin}/zorac --help 2>&1", 2)
  end
end