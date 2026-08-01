# Nixconf

This is my nix configuration, It has been rewritten multiple times and I have
learned a significant amount of functional language and linux over time with it.

> [!Note]
> This configuration is just for my personal use on my devices. You can
> use it for reference but please don't use the entire config for your setup.
> It's not designed to be used by other people.
> Also, if you use my code it'd be appriciated if you star the repo and
> give me credit.

## Structure

My configuration follows the [Dentritic pattern][1] Flake.nix acts as the entry
point as any other normal nix configuration. Then import-tree is used to import
everything in .modules The main configuration is defined in every host's
machine.nix (currently I only have one). machine.nix imports the custom modules
which are defined in modules/nixos. Every host also has a packages.nix files for
simple packages which do not require a module to configure. The configuration is
made to be simple so I can focus on what I want in my system rather than on
making sure it's perfect. Not everything is done declaratively, and themes are
currently set by [noctalia][2] shell.

| file | description |
| ------ | ----- |
| flake.nix | Main flake |
| secrets/ | Sops secrets |
| Modules/ | Main modules |
| -> flake | Flake related configurations |
| -> hosts | Contains host specifics |
| -> packages | Wrapped packages |
| -> users | Contains user configuration |
| -> nixos/ | Custom nixos modules |
| --> core | Main modules which should be used by all hosts |
| --> desktop | Window manager configurations |
| --> programs | Most program configurations |
| --> services | Services, which mainly run in the background |
| --> themes.nix | simple theme related configuration |

## Credits and references

In places where I copy someone else's code or heavily took inspiration from I
will either list here or in that code file. Though, most of these were replaced
by my own logic and are no longer in the current version of my configuration.

[Vimjoyer](https://www.vimjoyer.com/) For sops, wrapped packages, and
impermenant system inspiration

[NotAShelf](https://github.com/NotAShelf) For nvf, hjem, and helping me learn
nix in the past

[1]: https://github.com/mightyiam/dendritic
[2]: https://github.com/noctalia-dev/noctalia
