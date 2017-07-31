require "formula"

class Kf5Kmymoney < Formula
  homepage "http://kmymoney.org/"
  head "git://anongit.kde.org/kmymoney.git", :branch => "frameworks"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  depends_on "haraldf/kf5/kf5-alkimia"
  depends_on "haraldf/kf5/kf5-kdiagram"
  depends_on "haraldf/kf5/kf5-kcmutils"
  depends_on "haraldf/kf5/kf5-khtml"
  depends_on "haraldf/kf5/kf5-kdelibs4support"

  def patches
    DATA
  end

  def install
    args = std_cmake_args

    args << "-DCMAKE_INSTALL_BUNDLEDIR=/Applications/KDE"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
diff --git a/kmymoney/kmymoney.cpp b/kmymoney/kmymoney.cpp
index c6ec8da..4ebbec7 100644
--- a/kmymoney/kmymoney.cpp
+++ b/kmymoney/kmymoney.cpp
@@ -64,6 +64,7 @@
 #include <QIcon>
 #include <QInputDialog>
 #include <QProgressDialog>
+#include <QStandardPaths>
 #include <QStatusBar>

 // ----------------------------------------------------------------------------
@@ -537,6 +538,13 @@ KMyMoneyApp::KMyMoneyApp(QWidget* parent) :
   layout->setSpacing(6);

   {
+    // See http://doc.qt.io/qt-5/qstandardpaths.html
+    QStringList themeSearchPaths = QStandardPaths::locateAll(
+            QStandardPaths::AppDataLocation,
+            QStringLiteral("icons"),
+            QStandardPaths::LocateDirectory | QStandardPaths::LocateFile);
+    themeSearchPaths += QStringLiteral(":/icons");
+    QIcon::setThemeSearchPaths(themeSearchPaths);
     QString themeName = KMyMoneySettings::iconsTheme();                 // get theme user wants
     if (!themeName.isEmpty() && themeName != QLatin1Literal("system"))  // if it isn't default theme then set it
       QIcon::setThemeName(themeName);
