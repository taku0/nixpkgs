{ stdenv, lib, buildMozillaMach, callPackage, fetchurl, fetchpatch, nixosTests }:

rec {
  thunderbird = thunderbird-102;

  thunderbird-102 = (buildMozillaMach rec {
    pname = "thunderbird";
    version = "102.11.0";
    application = "comm/mail";
    applicationName = "Mozilla Thunderbird";
    binaryName = pname;
    src = fetchurl {
      url = "mirror://mozilla/thunderbird/releases/${version}/source/thunderbird-${version}.source.tar.xz";
      sha512 = "8ae12ffab5893456f14df7417e1a9d5e0e754bdd743b2f3a42623ea57342f10de32763e56ff9ccf6938f89726e31d2a4062d4336a77918e884aac70a338f4130";
    };
    extraPatches = [
      # The file to be patched is different from firefox's `no-buildconfig-ffx90.patch`.
      ./no-buildconfig.patch
    ];

    meta = with lib; {
      changelog = "https://www.thunderbird.net/en-US/thunderbird/${version}/releasenotes/";
      description = "A full-featured e-mail client";
      homepage = "https://thunderbird.net/";
      maintainers = with maintainers; [ eelco lovesegfault pierron vcunat ];
      platforms = platforms.unix;
      badPlatforms = platforms.darwin;
      broken = stdenv.buildPlatform.is32bit; # since Firefox 60, build on 32-bit platforms fails with "out of memory".
                                             # not in `badPlatforms` because cross-compilation on 64-bit machine might work.
      license = licenses.mpl20;
    };
    updateScript = callPackage ./update.nix {
      attrPath = "thunderbird-unwrapped";
      versionPrefix = "102";
    };
  }).override {
    geolocationSupport = false;
    webrtcSupport = false;

    pgoSupport = false; # console.warn: feeds: "downloadFeed: network connection unavailable"
  };
}
