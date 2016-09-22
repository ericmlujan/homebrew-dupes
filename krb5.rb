class Krb5 < Formula
  desc "Network authentication protocol"
  homepage "http://web.mit.edu/kerberos/"
  url "http://web.mit.edu/kerberos/dist/krb5/1.14/krb5-1.14.4.tar.gz"
  sha256 "03a61a4280c9161771fb39019085dbe6a57aa602080515ff93b43cd6137e0b95"

  bottle do
    sha256 "d6c9632dcc50fbe987e43a6b4dca02422aadf448d7fbd53ebf75f419c3c118f4" => :el_capitan
    sha256 "a5616ee867f2cebf1108109e418b1668355c150b60942b6551e785c27680f3ed" => :yosemite
    sha256 "7e8182d2f02d34a517fb2601c9d9307539e8d6910f24cacd3ad17a5de711e53e" => :mavericks
  end

  keg_only :provided_by_osx

  depends_on "openssl"
  depends_on "bison" unless OS.mac?

  def install
    cd "src" do
      system "./configure",
        "--disable-debug",
        "--disable-dependency-tracking",
        "--disable-silent-rules",
        "--prefix=#{prefix}"
      system "make"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/krb5-config", "--version"
    assert_match include.to_s,
      shell_output("#{bin}/krb5-config --cflags")
  end
end
