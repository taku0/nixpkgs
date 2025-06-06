{
  lib,
  stdenv,
  fetchFromGitLab,
  meson,
  ninja,
  pkg-config,
  wrapGAppsHook4,
  desktop-file-utils,
  libadwaita,
  isocodes,
  json-glib,
  libipuz,
}:

stdenv.mkDerivation rec {
  pname = "crosswords";
  version = "0.3.12";

  src = fetchFromGitLab {
    domain = "gitlab.gnome.org";
    owner = "jrb";
    repo = "crosswords";
    rev = version;
    hash = "sha256-3RL2LJdIHmDAjXaxqsE0n5UQMsuBJWEMoyAEoSBemR0=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    wrapGAppsHook4
    desktop-file-utils
  ];

  buildInputs = [
    libadwaita
    isocodes
    json-glib
    libipuz
  ];

  meta = {
    description = "Crossword player and editor for GNOME";
    homepage = "https://gitlab.gnome.org/jrb/crosswords";
    changelog = "https://gitlab.gnome.org/jrb/crosswords/-/blob/${version}/NEWS.md?ref_type=tags";
    license = lib.licenses.gpl3Plus;
    mainProgram = "crosswords";
    maintainers = with lib.maintainers; [ aleksana ];
    platforms = lib.platforms.unix;
  };
}
