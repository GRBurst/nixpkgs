{ callPackage }:

let
  mkFlutter = opts: callPackage (import ./flutter.nix opts) { };
  getPatches = dir:
    let files = builtins.attrNames (builtins.readDir dir);
    in map (f: dir + ("/" + f)) files;
in {
  stable = mkFlutter {
    pname = "flutter";
    channel = "stable";
    version = "1.12.13+hotfix.8";
    sha256Hash = "01ik4xckr3fp65sq4g0g6wy5b9i0r49l643xmbxa6z9k21sby46d";
    patches = getPatches ./patches/stable;
  };
  beta = mkFlutter {
    pname = "flutter-beta";
    channel = "beta";
    version = "1.15.17";
    sha256Hash = "0iil6y6y477dhjgzx54ab5m9nj0jg4xl8x4zzd9iwh8m756r7qsd";
    patches = getPatches ./patches/beta;
  };
  dev = mkFlutter {
    pname = "flutter-dev";
    channel = "dev";
    version = "1.16.2";
    sha256Hash = "16sy9wbdpiqfhgs6nbgswfy2qpv923z4c3524nsj3knhlg2dfdr8";
    patches = getPatches ./patches/dev;
  };
}
