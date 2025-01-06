{
  programs.git = {
    enable = true;
    userEmail = "nyadiia@pm.me";
    userName = "nyadiia";
    signing = {
      key = "";
      signByDefault = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
