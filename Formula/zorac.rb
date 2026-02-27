class Zorac < Formula
  include Language::Python::Virtualenv

  desc "Self-hosted local LLM chat client for vLLM inference servers"
  homepage "https://github.com/chris-colinsky/zorac"
  url "https://files.pythonhosted.org/packages/8d/05/512c4d0d270e615e73336b7acc2ea7afb5adb50a472065e376a1a7117b0b/zorac-1.4.0.tar.gz"
  sha256 "185a8c82ab9776d98cb821f93746765aaee2a5217b36534a83b6c3c968ec245d"
  license "MIT"

  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  def relocate_binaries?
    false
  end

  test do
    assert_match "zorac", shell_output("#{bin}/zorac --help")
  end
end
