with import <nixpkgs> {};
with xorg;

stdenv.mkDerivation {
  name = "openbox";
  src = lib.cleanSource ./.;

  nativeBuildInputs = [ pkgconfig autoreconfHook ];

  buildInputs = [
    libxml2 libXinerama libXau libXrandr libICE libSM makeWrapper
  ];

  configureFlags = [
    "--disable-shared"
    "--disable-nls"
    "--disable-startup-notification"
    "--disable-xcursor"
    "--disable-session-management"
  ];

  propagatedBuildInputs = [
    pango imlib2
  ];

  # Openbox needs XDG_DATA_DIRS set or it can't find its default theme
  postInstall = ''
    wrapProgram "$out/bin/openbox" --prefix XDG_DATA_DIRS : "$out/share"
    rm $out/bin/openbox*session $out/bin/gdm-control $out/bin/gnome-panel-control
    rm -rf $out/libexec
    rm -rf $out/share/gnome-session
    rm -rf $out/share/xsessions
  '';
}
