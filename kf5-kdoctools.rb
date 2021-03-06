require "formula"

class Kf5Kdoctools < Formula
  url "http://download.kde.org/stable/frameworks/5.36/kdoctools-5.36.0.tar.xz"
  sha256 "327b90bd7b9fae2455ef848f44709ec8dbead1f1a86ef169083e9000d2edfb69"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kdoctools.git"

  depends_on "cmake" => :build
  depends_on "perl" => :build
  depends_on "cpanminus" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "qt5"
  depends_on "docbook"
  depends_on "docbook-xsl"
  depends_on "gettext"

  def patches
    DATA
  end

  def install

    system "cpanm", "URI"

    args = std_cmake_args

    args << "-DDocBookXML_CURRENTDTD_DIR:PATH=#{Formulary.factory("docbook").prefix}/docbook/xml/4.2"
    args << "-DDocBookXSL_DIR:PATH=#{Formulary.factory("docbook-xsl").prefix}/docbook-xsl"

    system "cmake", ".", *args
    system "make", "install"
    ln_s Dir["#{share}/kf5"], "#{Etc.getpwuid.dir}/Library/Application Support/", :force => true
    prefix.install "install_manifest.txt"
  end

  def caveats; <<-EOS.undent
    A symlink "#{ENV["HOME"]}/Library/Application Support/kf5" was created
    So that "kf5/kdoctools/customization" can be found when building other kf5 modules.

    This symlink can be removed when this formula is uninstalled.
    EOS
  end
end
