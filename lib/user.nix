_: {
  mkConfig = {userConfig, ...}: {
    mkez = userConfig;

    imports = [../modules/user];
  };
}
