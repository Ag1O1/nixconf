# Nixconf

This is my [Finix](https://github.com/finix-community/finix) configuration.

> [!Note]
> This configuration is just for my personal use on my devices. You can
> use it for reference but please don't use the entire config for your setup.
> It's not designed to be used by other people.
> Also, if you use my code it'd be appreciated if you star the repo and
> give credit.

## Structure

My configuration doesn't use flakes, instead it uses a custom mkSystem function
I wrote to make managing multiple systems for finix easier. And it uses tack for
pinning inputs. System.nix acts as the entry point having an atter set for each
host's default.nix.

The configuration uses a tag-based system to enable modules
inspired by [Iynaix](https://github.com/iynaix/dotfiles)'s configuration. Every
host has a packages.nix file for simple packages which do not require a module
to configure. The configuration is made to be simple so I can focus on what I
want in my system rather than overengineering the config too much. Not
everything is done declaratively (yet), and themes are currently set by
[noctalia](https://github.com/noctalia-dev/noctalia) shell.

The names of the host machines are based on random stars to avoid ending up with
unintuitive names like laptop1,laptop2,etc

| file | description |
| ------ | ----- |
| system.nix | Main entrypoint, atterset of hosts |
| .tack/pins.toml | Tack pins as a replacement for flakes |
| hosts/ | Contains host specifics |
| users/ | Contains user configuration |
| lib/mkSystem | Function for creating systems, similar to a usual flake.nix |
| modules/ | Main modules |
| -> core/ | Core modules, needed in most systems |
| -> hardware/ | Hardware related modules |
| -> desktop/ | Window manager configurations |
| -> programs/ | Most program configurations |
| -> services/ | Services, which mainly run in the background |
| -> theming.nix | simple theme configuration |

### AI use

I barely use AI in my configuration, the only time I do is when I want to do
something quickly where I dont have the time to research it at the moment,
it's mostly a convertion of something and I never let an AI touch my
configuration outside of what I specifically need.

Modules that are currently written using AI:

- asusd libudev-zer-patches
- virtmanager (converted from nixos module)
- rigel's custom kernel (converted from a custom kernel I configured myself)

### Credits and references

In places where I copy someone else's code or heavily took inspiration from I
will either list here or in that code file. Though, most of these were replaced
by my own logic and are no longer in the current version of my configuration.

[Vimjoyer](https://www.vimjoyer.com/) For sops, wrapped packages, and
impermanent system inspiration

[NotAShelf](https://github.com/NotAShelf) For nvf, hjem, and helping me learn
nix in the past

[Iynaix](https://github.com/iynaix/dotfiles), I took some inspiration from their
config mainly the preservation module.
