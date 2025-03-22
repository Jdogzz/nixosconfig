{
  config,
  lib,
  pkgs,
  ...
}:

{
  accounts.email = {
    accounts = {
      pacbell = {
        address = "jerzor@pacbell.net";
        primary = true;
        userName = "jerzor@pacbell.net";
        realName = "jerzor@pacbell.net";
        imap = {
          host = "imap.mail.att.net";
          port = 993;
          tls.enable = true;
        };
        mbsync = {
          enable = true;
          create = "maildir";
          expunge = "both";
        };
        msmtp.enable = true;
        mu.enable = true;
        smtp = {
          host = "smtp.mail.att.net";
          port = 465;
          tls = {
            enable = true;
          };
        };
        passwordCommand = "cat /run/agenix/secret3";
        maildir.path = "pacbell";
      };
      # outlook = {
      #   address = "virtualprocessor@outlook.com";
      #   userName = "virtualprocessor@outlook.com";
      #   realName = "virtualprocessor@outlook.com";
      #   imap = {
      #     host = "outlook.office365.com";
      #     port = 993;
      #     tls.enable = true;
      #   };
      #   mbsync = {
      #     enable = true;
      #     create = "maildir";
      #     expunge = "both";
      #   };
      #   msmtp.enable = true;
      #   mu.enable = true;
      #   smtp = {
      #     host = "smtp-mail.outlook.com";
      #     port = 587;
      #     tls = {
      #       enable = true;
      #       useStartTls = true;
      #     };
      #   };
      #   passwordCommand = "cat /run/agenix/secret1";
      #   maildir.path = "outlook";
      # };
      # comcast = {
      #   address = "jerzor@comcast.net";
      #   userName = "jerzor@comcast.net";
      #   realName = "jerzor@comcast.net";
      #   imap = {
      #     host = "imap.comcast.net";
      #     port = 993;
      #     tls = {
      #       enable = true;
      #     };
      #   };
      #   mbsync = {
      #     enable = true;
      #     create = "maildir";
      #     expunge = "both";
      #   };
      #   msmtp.enable = true;
      #   mu.enable = true;
      #   smtp = {
      #     host = "smtp.comcast.net";
      #     port = 587;
      #     tls.enable = true;
      #   };
      #   passwordCommand = "cat /run/agenix/secret2";
      #   maildir.path = "comcast";
      # };
    };
    maildirBasePath = "generalsync/reference/emails";
  };

  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.mu.enable = true;

  #Automatically synchronize with all mail servers and index it
  #Disabling this since I may have more than one computer active
  #I'll manually pull down mail when I need it
  # services.mbsync = {
  #   enable = true;
  #   postExec = "${pkgs.mu}/bin/mu index";
  # };

  #2025-03-20 Seems to no longer be necessary
  #Required for doom emacs
  # programs.fzf = {
  #   enable = true;
  # };
}
