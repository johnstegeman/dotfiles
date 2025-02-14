
{ pkgs, ...}: {

   programs.git = {
   enable = true;
   userEmail = "john.stegeman@gmail.com";
   signing.format = "ssh";
   delta.enable = true;
   delta.options = {
      navigate = true;
      light = false;
      syntax-theme = "Solarized (dark)";
      hyperlinks = true;
      side-by-side = true;
   };
   ignores = [
      ".DS_Store"
      "Desktop.ini"
      "._*"
      "Thumbs.db"
      ".Spotlight-V100"
      ".Trashes"
      "*.pyc"
      "*.out"
      "venv"
      "node_modules"
      ".sass-cache"
   ];
   extraConfig = {
      merge = {
         conflictstyle = "diff3";
      };
   };
  };
}




