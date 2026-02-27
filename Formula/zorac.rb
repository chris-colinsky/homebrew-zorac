class Zorac < Formula
  desc "Self-hosted local LLM chat client for vLLM inference servers"
  homepage "https://github.com/chris-colinsky/zorac"
  url "https://files.pythonhosted.org/packages/8d/05/512c4d0d270e615e73336b7acc2ea7afb5adb50a472065e376a1a7117b0b/zorac-1.4.0.tar.gz"
  sha256 "185a8c82ab9776d98cb821f93746765aaee2a5217b36534a83b6c3c968ec245d"
  license "MIT"

  depends_on "python@3.13"

  skip_clean "libexec"

  def install
    python = Formula["python@3.13"].opt_bin/"python3.13"

    system python, "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    system libexec/"bin/pip", "install", "zorac==1.4.0"

    # Some pip wheels (e.g. jiter from openai) lack -headerpad_max_install_names,
    # so Homebrew's relocation step fails trying to rewrite their @rpath dylib IDs
    # to long absolute paths. Changing the ID to just the filename is safe for
    # Python extension modules, which are loaded by file path, not dylib ID.
    libexec.glob("lib/python3.13/site-packages/**/*.so") do |so|
      system "install_name_tool", "-id", so.basename.to_s, so
    end

    (bin/"zorac").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/bin/zorac" "$@"
    EOS
  end

  test do
    assert_match "zorac", shell_output("#{bin}/zorac --help")
  end
end
