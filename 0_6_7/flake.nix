{
  description = ''Continuation-Passing Style for Nim link'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-github-nim-works-cps-0_6_7.flake = false;
  inputs.src-github-nim-works-cps-0_6_7.ref   = "refs/tags/0.6.7";
  inputs.src-github-nim-works-cps-0_6_7.owner = "nim-works";
  inputs.src-github-nim-works-cps-0_6_7.repo  = "cps";
  inputs.src-github-nim-works-cps-0_6_7.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-github-nim-works-cps-0_6_7"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-github-nim-works-cps-0_6_7";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}