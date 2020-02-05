{ asciidoc, fetchurl, stdenv, libconfuse, yajl, alsaLib, libpulseaudio, libnl, pkgconfig, autoconf, automake, xmlto }:

stdenv.mkDerivation rec {
  name = "i3status-2.13";

  src = fetchurl {
    url = "https://i3wm.org/i3status/${name}.tar.bz2";
    sha256 = "0rhlzb96mw64z2jnhwz9nibc7pxg549626lz5642xxk5hpzwk2ff";
  };

  nativeBuildInputs = [ autoconf automake pkgconfig ];
  buildInputs = [ asciidoc libconfuse yajl alsaLib libpulseaudio libnl xmlto ];

  meta = {
    description = "A tiling window manager";
    homepage = https://i3wm.org;
    maintainers = [ ];
    license = stdenv.lib.licenses.bsd3;
    platforms = stdenv.lib.platforms.all;
  };

}
