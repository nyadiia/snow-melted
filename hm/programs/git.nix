{
  programs.git = {
    enable = true;
    userEmail = "auctumnus@pm.me";
    userName = "Autumn";
    signing = {
      key = "E1542373839B2670";
      signByDefault = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
