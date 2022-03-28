{
  description = ''Continuation-Passing Style for Nim link'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-github-nim-works-cps-0_0_32.flake = false;
  inputs.src-github-nim-works-cps-0_0_32.ref   = "refs/tags/0.0.32";
  inputs.src-github-nim-works-cps-0_0_32.owner = "nim-works";
  inputs.src-github-nim-works-cps-0_0_32.repo  = "cps";
  inputs.src-github-nim-works-cps-0_0_32.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-github-nim-works-cps-0_0_32"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-github-nim-works-cps-0_0_32";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}