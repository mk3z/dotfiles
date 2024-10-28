{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
  gpgKey = pkgs.fetchurl {
    url = "https://keys.openpgp.org/vks/v1/by-fingerprint/${osConfig.mkez.user.key}";
    # NOTE: This is sub-optimal since it has to be changed each time the pubkey changes
    sha256 = "WkEqgFUoMp3MpWI1oKBMyTXhilZlPPKrqesQsUZq8EY=";
  };
in {
  programs.gpg = {
    enable = true;
    scdaemonSettings.disable-ccid = true;
    publicKeys = [
      {
        source = "${gpgKey}";
        trust = 5;
      }
    ];

    settings = {
      # Use AES256, 192, or 128 as cipher
      personal-cipher-preferences = "AES256 AES192 AES";
      # Use SHA512, 384, or 256 as digest
      personal-digest-preferences = "SHA512 SHA384 SHA256";
      # Use ZLIB, BZIP2, ZIP, or no compression
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
      # Default preferences for new keys
      default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
      # SHA512 as digest to sign keys
      cert-digest-algo = "SHA512";
      # SHA512 as digest for symmetric ops
      s2k-digest-algo = "SHA512";
      # AES256 as cipher for symmetric ops
      s2k-cipher-algo = "AES256";
      # UTF-8 support for compatibility
      charset = "utf-8";
      # No comments in messages
      no-comments = true;
      # No version in output
      no-emit-version = true;
      # Disable banner
      no-greeting = true;
      # Long key id format
      keyid-format = "0xlong";
      # Display UID validity
      list-options = "show-uid-validity";
      verify-options = "show-uid-validity";
      # Display all keys and their fingerprints
      with-fingerprint = true;
      # Cross-certify subkeys are present and valid
      require-cross-certification = true;
      # Disable caching of passphrase for symmetrical ops
      no-symkey-cache = true;
      # Output ASCII instead of binary
      armor = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = osConfig.mkez.hardware.yubikey.enable;
    pinentryPackage = pkgs.pinentry-curses;
  };

  home.persistence."${homePersistDir}${homeDirectory}".directories = [".gnupg"];
}
