class Zorac < Formula
  desc "Self-hosted local LLM chat client for vLLM inference servers"
  homepage "https://github.com/chris-colinsky/zorac"
  url "https://files.pythonhosted.org/packages/8f/67/28de9fe16b8869795f43b36eb256cbd93324e553c26997ce3e39305177ac/zorac-1.3.1.tar.gz"
  sha256 "165c097b2e1bc1e1e30501e68938b2a91c27f9e68790814703848506204909c3"
  license "MIT"

  depends_on "python@3.13"

  skip_clean "libexec"

  def install
    python = Formula["python@3.13"].opt_bin/"python3.13"

    system python, "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    system libexec/"bin/pip", "install", "zorac==1.3.1"

    (bin/"zorac").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/bin/zorac" "$@"
    EOS
  end

  test do
    assert_match "Zorac", shell_output("#{bin}/zorac --help 2>&1", 2)
  end
end
