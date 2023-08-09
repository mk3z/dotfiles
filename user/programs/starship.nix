{
  enable = true;
  settings = {
    right_format = "$cmd_duration $time";

    character = {
      success_symbol = "[λ](green)";
      error_symbol = "[λ](red)";
      vimcmd_symbol = "[λ](blue)";
      vimcmd_replace_one_symbol = "[λ](purple)";
      vimcmd_replace_symbol = "[λ](purple)";
      vimcmd_visual_symbol = "[λ](yellow)";
    };

    cmd_duration = {
      show_milliseconds = true;
      format = "[$duration]($style) ";
      style = "bright-black";
    };

    directory = {
      style = "bold blue";
      truncation_symbol = ".../";
    };

    hostname = {
      disabled = true;
    };

    time = {
      format = "[$time]($style) ";
      style = "bright-black";
      disabled = false;
    };

    username.disabled = true;

    # Nerd Font symbols preset
    # https://starship.rs/presets/nerd-font.html
    aws.symbol = "  ";
    buf.symbol = " ";
    c.symbol = " ";
    conda.symbol = " ";
    dart.symbol = " ";
    directory.read_only = " 󰌾";
    docker_context.symbol = " ";
    elixir.symbol = " ";
    elm.symbol = " ";
    git_branch.symbol = " ";
    golang.symbol = " ";
    guix_shell.symbol = " ";
    haskell.symbol = " ";
    haxe.symbol = "⌘ ";
    hg_branch.symbol = " ";
    java.symbol = " ";
    julia.symbol = " ";
    lua.symbol = " ";
    memory_usage.symbol = "󰍛 ";
    meson.symbol = "󰔷 ";
    nim.symbol = "󰆥 ";
    nix_shell.symbol = " ";
    nodejs.symbol = " ";
    os.symbols = {
      Alpine = " ";
      Amazon = " ";
      Android = " ";
      Arch = " ";
      CentOS = " ";
      Debian = " ";
      DragonFly = " ";
      Emscripten = " ";
      EndeavourOS = " ";
      Fedora = " ";
      FreeBSD = " ";
      Garuda = "󰛓 ";
      Gentoo = " ";
      HardenedBSD = "󰞌 ";
      Illumos = "󰈸 ";
      Linux = " ";
      Macos = " ";
      Manjaro = " ";
      Mariner = " ";
      MidnightBSD = " ";
      Mint = " ";
      NetBSD = " ";
      NixOS = " ";
      OpenBSD = "󰈺 ";
      openSUSE = " ";
      OracleLinux = "󰌷 ";
      Pop = " ";
      Raspbian = " ";
      Redhat = " ";
      RedHatEnterprise = " ";
      Redox = " ";
      Solus = "󰠳 ";
      SUSE = " ";
      Ubuntu = " ";
      Unknown = " ";
      Windows = "󰍲 ";
    };
    package.symbol = "󰏗 ";
    python.symbol = " ";
    rlang.symbol = "󰟔 ";
    ruby.symbol = " ";
    rust.symbol = " ";
    scala.symbol = " ";
    spack.symbol = "🅢 ";
  };
}
