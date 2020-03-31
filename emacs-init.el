;;(setq custom-file "~/.emacs-custom")
;;(load custom-file 'noerror)

(load "~/hoovy/emacs.el")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(blink-cursor-mode nil)
 '(c-basic-offset 4 t)
 '(custom-enabled-themes '(tango-dark))
 '(custom-unlispify-menu-entries t)
 '(default-input-method "hebrew")
 '(erc-autojoin-channels-alist
   '(("freenode.net" "#xelf" "##prolog" "#gamedev" "#clim" "#lispgames" "#lisp" "#emacs" "#GNUstep")
     ("quakenet" "#rgrd")))
 '(erc-fill-column 80)
 '(erc-hide-timestamps t)
 '(erc-log-mode nil)
 '(erc-log-write-after-insert t)
 '(erc-log-write-after-send t)
 '(erc-modules
   '(autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring services stamp track))
 '(erc-networks-alist
   '((4-irc "4-irc.com")
     (A5KNet "a5knet.com")
     (AbleNet "ablenet.org")
     (Accessirc "accessirc.net")
     (Acestar "acestar.org")
     (Action-IRC "action-irc.net")
     (AfterNET "afternet.org")
     (Alternativenet "altnet.org")
     (AmigaNet "amiganet.org")
     (AngelEyez "angeleyez.net")
     (Anothernet "another.net")
     (ArabChat "arabchat.org")
     (Ars "arstechnica.com")
     (AsiaTalk "asiatalk.org")
     (AstroLink "astrolink.org")
     (Asylumnet "asylumnet.org")
     (Austnet "austnet.org")
     (AwesomeChat "awesomechat.net")
     (Awesomechristians "awesomechristians.com")
     (Axenet "axenet.org")
     (Beyondirc "beyondirc.net")
     (BGIRC "bulgaria.org")
     (Blabbernet "blabber.net")
     (Blitzed "blitzed.org")
     (BrasIRC "brasirc.net")
     (BRASnet "brasnet.org")
     (BubbleNet "bubblenet.org")
     (CCnet "christian-chat.net")
     (Chat-Net "chat-net.org")
     (Chat-Solutions "chat-solutions.org")
     (Chatcafe "chatcafe.net")
     (Chatchannel "chatchannel.org")
     (ChatCircuit "chatcircuit.com")
     (Chatlink "chatlink.org")
     (Chatnet "chatnet.org")
     (ChatNut "chatnut.net")
     (Chatpinoy "chatpinoy.com")
     (ChatPR "chatpr.org")
     (Chatroom "chatroom.org")
     (Chatster "chatster.org")
     (ChatX "chatx.net")
     (China263 "263.net")
     (Cineplex1 "cineplex1.com")
     (CNN "cnn.com")
     (CobraNet "cobra.net")
     (Coolchat "coolchat.net")
     (Criten "criten.net")
     (Cyberchat "cyberchat.org")
     (CyGanet "cyga.net")
     (DALnet "dal.net")
     (Dark-Tou-Net "d-t-net.de")
     (Darkfire "darkfire.net")
     (DarkMyst "darkmyst.org")
     (Darkserv "darkserv.net")
     (Darksystem "darksystem.com")
     (Darktree "darktree.net")
     (DayNet "daynet.org")
     (Deepspace "deepspace.org")
     (Different "different.net")
     (Digarix "digarix.net")
     (Digatech "digatech.net")
     (Digital-Base "digital-base.net")
     (Digitalirc "digitalirc.net")
     (Discussioni "discussioni.org")
     (DorukNet "doruk.net.tr")
     (DWChat "dwchat.net")
     (Dynastynet "dynastynet.net")
     (EFnet nil)
     (EgyptianIRC "egyptianirc.net")
     (Eircnet "eircnet.org")
     (Eleethal "eleethal.com")
     (EntertheGame "enterthegame.com")
     (EpiKnet "epiknet.org")
     (EsperNet "esper.net")
     (Esprit "esprit.net")
     (euIRC "euirc.net")
     (Evilzinc "evilzinc.net")
     (ExodusIRC "exodusirc.net")
     (FDFnet "fdfnet.net")
     (FEFnet "fef.net")
     (Financialchat "financialchat.com")
     (Forestnet "forestnet.org")
     (ForeverChat "foreverchat.net")
     (Fraggers "fraggers.co.uk")
     (FreedomChat "freedomchat.net")
     (FreedomIRC "freedomirc.net")
     (freenode "freenode.net")
     (FunNet "funnet.org")
     (GalaxyNet "galaxynet.org")
     (Gamesnet "gamesnet.net")
     (GammaForce "gammaforce.org")
     (GIKInet "giki.edu.pk")
     (GizNet "giznet.org")
     (Globalchat "globalchat.org")
     (GlobIRC "globirc.net")
     (Goldchat "goldchat.nl")
     (Goodchatting "goodchatting.com")
     (GravityLords "gravitylords.net")
     (GRnet "irc.gr")
     (GulfChat "gulfchat.net")
     (HabberNet "habber.net")
     (HanIRC "hanirc.org")
     (Hellenicnet "mirc.gr")
     (IceNet "icenet.org.za")
     (ICQnet "icq.com")
     (iip "anon.iip")
     (Infatech "infatech.net")
     (Infinity "infinity-irc.org")
     (Infomatrix "infomatrix.net")
     (Inside3D "inside3d.net")
     (InterlinkChat "interlinkchat.net")
     (IRC-Chile "irc.cl")
     (IRC-Hispano "irc-hispano.org")
     (IRCchat "ircchat.tk")
     (IRCGate "ircgate.net")
     (IRCGeeks "ircgeeks.org")
     (IRChat "irchat.net")
     (IrcLordz "irclordz.com")
     (IrcMalta "ircmalta.org")
     (IRCnet nil)
     (IRCSoulZ "ircsoulz.net")
     (IRCSul "wnet.com.br")
     (IrcTalk "irctalk.net")
     (Irctoo "irctoo.net")
     (IRCtown "irc.irctown.net")
     (IRCworld "ircworld.org")
     (ircXtreme "ircXtreme.net")
     (Israelnet "israel.net")
     (K0wNet "k0w.net")
     (KDFSnet "kdfs.net")
     (Kemik "kemik.net")
     (Kewl\.Org "kewl.org")
     (Kickchat "kickchat.com")
     (KidsWorld "kidsworld.org")
     (Knightnet "knightnet.net")
     (Konfido\.Net "konfido.net")
     (Kreynet "krey.net")
     (Krono "krono.net")
     (Krushnet "krushnet.org")
     (LagNet "lagnet.org.za")
     (Librenet "librenet.net")
     (LinkNet "link-net.org")
     (LinuxChix "cats\\.meow\\.at\\|linuxchix\\.org")
     (Liquidized "liquidized.net")
     (M-IRC "m-sys.org")
     (MagicStar "magicstar.net")
     (Mavra "mavra.net")
     (MediaDriven "mediadriven.com")
     (mIRC-X "mircx.com")
     (Morat "morat.net")
     (MusicCity "musiccity.com")
     (Mysteria "mysteria.net")
     (Mysterychat "mysterychat.net")
     (Mystical "mystical.net")
     (Narancs "narancs.com")
     (Net-France "net-france.com")
     (Nevernet "nevernet.net")
     (Newnet "newnet.net")
     (Nexusirc "nexusirc.org")
     (NightStar "nightstar.net")
     (NitrousNet "nitrousnet.net")
     (Novernet "novernet.com")
     (Nullrouted "nullrouted.org")
     (NullusNet "nullus.net")
     (OFTC "oftc.net")
     (OpChat "opchat.org")
     (Openprojects "openprojects.net")
     (Othernet "othernet.org")
     (OtherSide "othersideirc.net")
     (Outsiderz "outsiderz.com")
     (OzOrg "oz.org")
     (Peacefulhaven "peacefulhaven.net")
     (PhazedIRC "phazedirc.net")
     (Philchat "philchat.net")
     (phrozN "phrozn.net")
     (PiNet "praetorians.org")
     (Pinoycentral "abs-cbn.com")
     (Planetarion "planetarion.com")
     (POLNet "ircnet.pl")
     (Psionics "psionics.net")
     (PTirc "ptirc.com.pt")
     (PTlink "ptlink.net")
     (PTnet "ptnet.org")
     (QChat "qchat.net")
     (QuakeNet "quakenet.org")
     (Realirc "realirc.org")
     (RealmNET "realmnet.com")
     (Rebelchat "rebelchat.org")
     (Red-Latina "red-latina.org")
     (RedLatona "redlatona.net")
     (Relicnet "relic.net")
     (Rezosup "rezosup.org")
     (Risanet "risanet.com")
     (Rubiks "rubiks.net")
     (Rusnet "nil")
     (Sandnet "sandnet.net")
     (Scunc "scunc.net")
     (SerbianCafe "serbiancafe.ws")
     (SexNet "sexnet.org")
     (ShadowFire "shadowfire.org")
     (ShadowWorld "shadowworld.net")
     (SkyNet "bronowski.pl")
     (SlashNET "slashnet.org")
     (SolarStone "solarstone.net")
     (Sorcery "sorcery.net")
     (SourceIRC "sourceirc.net")
     (SpaceTronix "spacetronix.net")
     (Spirit-Harmony "spirit-harmony.com")
     (StarChat "starchat.net")
     (StarEquinox "starequinox.net")
     (Starlink "starlink.net")
     (starlink-irc "starlink-irc.org")
     (StarWars-IRC "starwars-irc.net")
     (Stormdancing "stormdancing.net")
     (Superchat "superchat.org")
     (Sysopnet "sysopnet.org")
     (Telstra "telstra.com")
     (TR-net "dominet.com.tr")
     (Tri-net "tri-net.org")
     (TriLink "ft4u.net")
     (TurkishChat "turkishchat.org")
     (UberNinja "uberninja.net")
     (UICN "uicn.net")
     (UltraIRC "ultrairc.net")
     (UnderChat "underchat.it")
     (Undernet "undernet.org")
     (UnderZ "underz.org")
     (UniChat "irc.uni-chat.net")
     (UnionLatina "unionlatina.org")
     (Univers "univers.org")
     (UnixR "unixr.net")
     (Vidgamechat "vidgamechat.com")
     (VirtuaNet "virtuanet.org")
     (Vitamina "vitamina.ca")
     (Voila "voila.fr")
     (Wahou "wf-net.org")
     (Warpednet "warped.net")
     (Weaklinks "weaklinks.net")
     (Webnet "webchat.org")
     (WinChat "winchat.net")
     (WinIRC "winirc.org")
     (WorldIRC "worldirc.org")
     (WyldRyde "wyldryde.net")
     (XentoniX "xentonix.net")
     (Xevion "xevion.net")
     (XNet "xnet.org")
     (XWorld "xworld.org")
     (ZAnetNet "zanet.net")
     (ZAnetOrg "zanet.org.za")
     (ZiRC "zirc.org")
     (ZUHnet "zuh.net")
     (Zurna "zurna.net")
     (QuakeNet "quakenet.org")))
 '(erc-nick "oni-on-ion")
 '(erc-nickserv-passwords '((Ars (("on_ion" . "1passported2")))))
 '(erc-save-buffer-on-part t)
 '(erc-save-queries-on-quit t)
 '(erc-server-flood-margin 1)
 '(erlang-indent-level 4)
 '(font-lock-maximum-decoration t)
 '(hoovy-root "~/hoovy/")
 '(menu-bar-mode nil)
 '(merlin-command "ocamlmerlin")
 '(org-attach-store-link-p 'attached)
 '(org-babel-load-languages '((emacs-lisp . t) (shell . t) (lisp . t)))
 '(package-selected-packages
   '(ob-prolog guix elnode julia-mode julia-repl julia-shell tuareg geiser keyfreq trident-mode treemacs treemacs-icons-dired treemacs-magit company-erlang indium merlin-eldoc company-lsp company-restclient company-shell elisp-def suggest xml-rpc google-translate dune ac-slime helpful rmsbolt erc-hl-nicks web-server edts auto-complete reason-mode quelpa package-build expand-region persistent-scratch hyperbole charmap circe flycheck flycheck-ocaml flyspell-popup merlin utop webpaste helm helm-dash helm-emms helm-org-rifle helm-package helm-proc emms github-browse-file github-clone sx memory-usage es-lib svg-clock htmlize simple-httpd websocket dictionary "bbdb" ediprolog which-key ggtags common-lisp-snippets el-autoyas yasnippet snoopy hackernews elfeed eyebrowse hierarchy projectile rainbow-blocks rainbow-delimiters esxml exwm rainbow-mode emacsql csound-mode haskell-emacs haskell-emacs-base haskell-emacs-text haskell-mode erlang swift-mode racer rust-mode slime slime-company))
 '(persistent-scratch-autosave-interval 3000)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(swift-mode:repl-executable "swift")
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(treemacs-show-hidden-files nil)
 '(treemacs-silent-refresh nil)
 '(treemacs-width 30)
 '(tuareg-font-lock-symbols t)
 '(tuareg-highlight-all-operators t t)
 '(tuareg-prettify-symbols-full t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#101010" :foreground "#ccc" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "misc" :family "fixed"))))
 '(erc-input-face ((t (:foreground "#f9f"))))
 '(erc-my-nick-face ((t (:foreground "#f9f" :weight bold))))
 '(font-lock-builtin-face ((t (:foreground "#8f8"))))
 '(font-lock-comment-face ((t (:foreground "#666"))))
 '(font-lock-constant-face ((t (:foreground "#8ff"))))
 '(font-lock-doc-face ((t (:inherit font-lock-comment-face))))
 '(font-lock-function-name-face ((t (:foreground "#c8c"))))
 '(font-lock-keyword-face ((t (:foreground "green"))))
 '(font-lock-preprocessor-face ((t (:foreground "yellow"))))
 '(font-lock-string-face ((t (:foreground "#fff"))))
 '(font-lock-type-face ((t (:foreground "#99d790"))))
 '(font-lock-variable-name-face ((t (:foreground "#88f"))))
 '(highlight ((t (:background "#334400" :foreground "#ffffff"))))
 '(merlin-type-face ((t (:inherit caml-types-expr-face :background "skyblue" :foreground "black"))))
 '(org-meta-line ((t (:inherit font-lock-comment-face))))
 '(org-special-keyword ((t (:inherit font-lock-variable-name-face))))
 '(org-table ((t (:foreground "cyan"))))
 '(outline-1 ((t (:inherit font-lock-keyword-face))))
 '(outline-2 ((t (:inherit font-lock-preprocessor-face))))
 '(outline-3 ((t (:inherit font-lock-function-name-face))))
 '(outline-4 ((t (:inherit font-lock-type-face))))
 '(outline-5 ((t (:inherit font-lock-variable-name-face))))
 '(rainbow-delimiters-depth-1-face ((t (:inherit rainbow-delimiters-base-face :foreground "yellow"))))
 '(rainbow-delimiters-depth-2-face ((t (:inherit rainbow-delimiters-base-face :foreground "#fc0"))))
 '(rainbow-delimiters-depth-3-face ((t (:inherit rainbow-delimiters-base-face :foreground "#f90"))))
 '(rainbow-delimiters-depth-4-face ((t (:inherit rainbow-delimiters-base-face :foreground "#f70"))))
 '(rainbow-delimiters-depth-5-face ((t (:inherit rainbow-delimiters-base-face :foreground "#f50"))))
 '(rainbow-delimiters-depth-6-face ((t (:inherit rainbow-delimiters-base-face :foreground "#f30"))))
 '(rainbow-delimiters-depth-7-face ((t (:inherit rainbow-delimiters-base-face :foreground "#f06"))))
 '(rainbow-delimiters-depth-8-face ((t (:inherit rainbow-delimiters-base-face :foreground "#f0a"))))
 '(rainbow-delimiters-depth-9-face ((t (:inherit rainbow-delimiters-base-face :foreground "#f0d"))))
 '(region ((t (:background "#333333"))))
 '(secondary-selection ((t (:background "#203960"))))
 '(slime-highlight-edits-face ((t (:background "#222"))))
 '(tuareg-font-lock-governing-face ((t (:foreground "green"))))
 '(tuareg-font-lock-module-face ((t (:inherit font-lock-type-face))))
 '(tuareg-font-lock-operator-face ((t (:foreground "yellow"))))
 '(utop-stderr ((t (:foreground "#faa"))) t))
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
