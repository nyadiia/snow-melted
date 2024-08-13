{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "kmwc.org" = {
        forwardAgent = true;
      };
    };
  };
  services.ssh-agent.enable = true;
}
