{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    appimage-run
    curl
    btop
    whois
    wine-staging # needed to delete .wine folder
    winetricks
    unzip
    pkgs.ffmpeg # fyrir jellyfin
    linssid
    libsForQt5.breeze-gtk # for KDE styles in firefox
    libsForQt5.kde-gtk-config
    xdg-desktop-portal
    libsForQt5.xdg-desktop-portal-kde # for KDE styles in firefox
    tree
    pciutils
    lm_sensors
    via
    cura
    usbutils
  ];
}
