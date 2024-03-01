{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
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
