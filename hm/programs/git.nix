{
  programs.git = {
    enable = true;
    userEmail = "nyadiia@pm.me";
    userName = "nyadiia";
    signing = {
      key = "178B4B1243860873";
      signByDefault = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
