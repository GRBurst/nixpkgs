{ stdenv, fetchFromGitHub, mkDerivation
, pkgconfig, qtbase, qttools, qmake, qtmultimedia, qtx11extras, libv4l, libXrandr
, gst-plugins-base, gst-plugins-good, gst-plugins-bad
, libpulseaudio, alsaLib
, zbar
}:
mkDerivation rec {

  pname = "vokoscreenNG";
  version = "3.0.2";

  src = fetchFromGitHub {
    owner   = "vkohaupt";
    repo    = "vokoscreenNG";
    rev     = version;
    sha256  = "06qszbwvmkn12mr1gqnfd5x6my782kwy1m325s6lqfrk4ckrp1bc";
  };

  nativeBuildInputs = [ pkgconfig qmake ];
  buildInputs = [
    gst-plugins-base gst-plugins-good gst-plugins-bad
    alsaLib libpulseaudio
    libv4l
    libXrandr
    qtbase
    qtmultimedia
    qttools
    qtx11extras
    zbar
  ];

  preConfigure = ''
    sed -i 's/lrelease-qt5/lrelease/g' vokoscreen.pro
  '';

  meta = with stdenv.lib; {
    description = "Simple GUI screencast recorder based on gstreamer";
    homepage = "https://linuxecke.volkoh.de/vokoscreen/vokoscreen.html";
    longDescription = ''
      vokoscreenNG is an easy to use screencast creator to record
      educational videos, live recordings of browser, installation,
      videoconferences, etc.
    '';
    license = licenses.gpl2Plus;
    maintainers = [ maintainers.grburst ];
    platforms = platforms.linux;
  };
}
