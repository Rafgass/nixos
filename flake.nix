{
  description = "My first flake";

  inputs = {
    # nixpkgs = {
    #  url = "github:NixOS/nixpkgs/nixos-unstable"; or /nixpkgs/nixos-23.11 or whatever release


    # Use nixpkgs.url for UNSTABLE
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # does the same as above code, can ignore github: blah blah because nix knows its own repo

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    # unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # for later! 
    # home-manager.url = "github:nix-community/home-manager/nixos-23.11"; # where 23.11 would change to 24.05 on next stable
    home-manager.url = "github:nix-community/home-manager/master"; # master is the unstable branch
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # }
  }; # some git repo, nxpkgs for example

  outputs = inputs@{
    self,
    nixpkgs,
    home-manager,
    nixpkgs-stable,
    ... }:
    {
    nixosConfigurations = {
      nixos-desk = nixpkgs.lib.nixosSystem  rec { # "lib" is defined above
        system = "x86_64-linux";
        specialArgs = {
          # To use nixpkgs-stable in my modules
          pkgs-stable = import nixpkgs-stable {
            system = system;
            # lets add unfree just in case
            config.allowUnfree = true;
          };
        };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kodak = import ./home.nix;           
          }
        ];
      }; # This is a function that makes the nixos system  
    };
  }; # my built system  
}
