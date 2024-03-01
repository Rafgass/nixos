{
  description = "The packages I want installed";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; 
  };

  outputs = {
    self,
    nixpkgs, 
  }; 
  
}


{ config, pkgs, ... }; {
 


  
}
