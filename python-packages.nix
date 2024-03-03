{pkgs-stable, ...}: {
  environment.systemPackages = with pkgs-stable; [
    (python3.withPackages (ps:
      with ps; [
        basemap
        matplotlib
        jupyter
        pandas
        numpy
        scipy
        pydy # python dynamics
        pybullet # physics engine
        python-lsp-server
        pygame
      ]))
  ];
}
