{ stdenv
, lib
, fetchFromGitLab
, bash
, makeWrapper
, bc
, scowl
, wordlist ? "${scowl}/share/dict/words.txt"
, preferrededitor ? "$EDITOR"
}:
stdenv.mkDerivation {
  pname = "wordy";
  version = "1.0.0";
  src = fetchFromGitLab {
    owner = "christosangel";
    repo = "wordy";
    rev = "16693b4cfc00b627c2e9487ab1c744752e6779d3";
    hash = "sha256-4hhTotU4+RpjCwhUndEbTsbQGKXXGczQzHaiz3OSKzI=";
  };
  buildInputs = [ bash ];
  nativeBuildInputs = [ makeWrapper ];
  runtimeDependencies = [
    scowl
    bc
  ];

  patchPhase = ''
    echo "mkdir -p ~/.local/share/wordy/" >> wordy.sh    
    sed -i '272s|.*|  WORD_LIST=${wordlist}\n  PREFERRED_EDITOR=${preferrededitor}|' wordy.sh
    sed -i '265,271d' wordy.sh
    sed -i 's|$HOME/.local/share/wordy/wordy.png|$(dirname "$0")/../share/icon.png|g' wordy.sh
  '';
  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share
    cp wordy.sh $out/bin/wordy
    cp wordy.png $out/share/icon.png
    wrapProgram $out/bin/wordy --prefix PATH : ${lib.makeBinPath [ bash bc ]}
  '';

  meta = with lib; {
    homepage = "https://gitlab.com/christosangel/wordy";
    description = "Wordy is a TUI word spelling puzzle in bash. You have 6 guesses to find out the secret 5-letter word.";
    license = licenses.gpl2Plus;
    platforms = lib.platforms.unix;
    maintainers = with maintainers; [ ilikefrogs101 ];
    mainProgram = "wordy";
  };
}
