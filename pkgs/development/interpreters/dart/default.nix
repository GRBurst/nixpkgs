{ stdenv, fetchurl, unzip, version ? "2.7.1" }:

let

  sources = let

    base = "https://storage.googleapis.com/dart-archive/channels";
    stable_version = "stable";
    dev_version = "dev";
    x86_64 = "x64";
    i686 = "ia32";

  in {
    "2.7.1-x86_64-linux" = fetchurl {
      url = "${base}/${stable_version}/release/${version}/sdk/dartsdk-linux-${x86_64}-release.zip";
      sha256 = "1zjd9hxxg1dsyzkzgqjvl933kprf8h143z5qi4mj1iczxv7zp27a";
    };
    "2.7.1-i686-linux" = fetchurl {
      url = "${base}/${stable_version}/release/${version}/sdk/dartsdk-linux-${i686}-release.zip";
      sha256 = "0cggr1jbhzahmazlhba0vw2chz9zxd98jgk6zxvxdnw5hvkx8si1";
    };
    "2.8.0-dev.9.0-x86_64-linux" = fetchurl {
      url = "${base}/${dev_version}/release/${version}/sdk/dartsdk-linux-${x86_64}-release.zip";
      sha256 = "1i1jmmmnljda0zwh8cf2k31635rg7yr1rm4nxsibxvgv6nma1czj";
    };
    "2.8.0-dev.9.0-i686-linux" = fetchurl {
      url = "${base}/${dev_version}/release/${version}/sdk/dartsdk-linux-${i686}-release.zip";
      sha256 = "1k9hs8f94zqgkb6vacqjv10bxpvhwr6imzz1n5cl1w5im98ww9rz";
    };
  };

in

stdenv.mkDerivation {

  pname = "dart";
  inherit version;

  nativeBuildInputs = [
    unzip
  ];

  src = sources."${version}-${stdenv.hostPlatform.system}" or (throw "unsupported version/system: ${version}/${stdenv.hostPlatform.system}");

  installPhase = ''
    mkdir -p $out
    cp -R * $out/
    echo $libPath
    patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
             --set-rpath $libPath \
             $out/bin/dart
  '';

  libPath = stdenv.lib.makeLibraryPath [ stdenv.cc.cc ];

  dontStrip = true;

  meta = {
    platforms = [ "i686-linux" "x86_64-linux" ];
    homepage = https://www.dartlang.org/;
    maintainers = with stdenv.lib.maintainers; [ grburst ];
    description = "Scalable programming language, with robust libraries and runtimes, for building web, server, and mobile apps";
    longDescription = ''
      Dart is a class-based, single inheritance, object-oriented language
      with C-style syntax. It offers compilation to JavaScript, interfaces,
      mixins, abstract classes, reified generics, and optional typing.
    '';
    license = stdenv.lib.licenses.bsd3;
  };
}
