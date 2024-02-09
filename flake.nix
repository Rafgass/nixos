{
  description = "My first flake";

  inputs = {
    # nixpkgs = {
    #  url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-unstable"; # does the same as above code, can ignore github: blah blah because nix knows its own repo
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # }
  }; # some git repo, nxpkgs for example

  outputs = {self, nixpkgs, home-manager,  ... }: # The "let" is a way to pass binding into other functions, so here we define "lib" to be used below
    let
      lib = nixpkgs.lib; 
    in {
    nixosConfigurations = {
      nixos-desk = lib.nixosSystem { # "lib" is defined above
        system = "x86_64-linux";
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
