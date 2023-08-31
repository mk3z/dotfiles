{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      AddKeysToAgent yes
    '';
  };

  services.ssh-agent.enable = true;
}
