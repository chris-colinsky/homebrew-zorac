class Zorac < Formula
  desc "Self-hosted local LLM chat client for vLLM inference servers"
  homepage "https://github.com/chris-colinsky/zorac"
  url "https://files.pythonhosted.org/packages/41/95/819b307893db0c3e95c482cc00fd9ac6b69f49f73a1f98e097703446c206/zorac-1.3.0.tar.gz"
  sha256 "af7da50af668784073474a1cfcc7ba37a2a4ea288a1bce9ed3ad37306ade36ee"
  license "MIT"

  depends_on "python@3.13"

  skip_clean "libexec"

  def install
    python = Formula["python@3.13"].opt_bin/"python3.13"

    system python, "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    system libexec/"bin/pip", "install", "zorac==1.3.0"

    (bin/"zorac").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/bin/zorac" "$@"
    EOS
  end

  test do
    assert_match "Zorac", shell_output("#{bin}/zorac --help 2>&1", 2)
  end
end
