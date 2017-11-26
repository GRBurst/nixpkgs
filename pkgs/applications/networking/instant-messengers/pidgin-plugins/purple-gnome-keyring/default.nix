{ stdenv, fetchFromGitHub, pkgconfig, pidgin, json_glib, glib, libsecret, dbus, dbus_glib } :

let
  version = "v1.1.3";
in
stdenv.mkDerivation rec {
  name = "purple-gnome-keyring-${version}";

  src = fetchFromGitHub {
    owner = "grburst";
    repo = "purple-gnome-keyring";
    rev = "${version}";
    sha256 = "06z2kp5hnd2vs9sk775mwhpxg2hf27c9a3yfwgr87g8affb1i0yh";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ pidgin dbus json_glib dbus_glib glib libsecret ];

  makeFlags = "PREFIX=$(out)";
  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/lib/purple-2/
    install -Dm755 *.so $out/lib/purple-2/
  '';

  meta = with stdenv.lib; {
    homepage = https://github.com/grburst/purple-gnome-keyring;
    description = "Gnome Keyring integration for for Pidgin / libpurple";
    license = stdenv.lib.licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ GRBurst ];
  };
}
