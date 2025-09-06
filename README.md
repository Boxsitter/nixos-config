# NixOS Configuration - KDE Plasma Dual Boot Setup

A modular NixOS configuration designed for dual-boot systems with Windows, featuring KDE Plasma 6 desktop environment.

## Features

- 🖥️ KDE Plasma 6 desktop environment
- 🚀 Fish shell with custom functions and Starship prompt
- 🎨 Catppuccin Macchiato theme system-wide
- 🖥️ Kitty terminal with JetBrains Mono Nerd Font
- 🔧 GRUB bootloader configured for dual-boot
- 📦 Modular configuration structure
- 🎮 NVIDIA/AMD graphics support
- 🔊 PipeWire audio system

## Setup Instructions

### 1. Initial Installation

1. Boot from NixOS installer ISO
2. Partition your disk (leaving Windows partition intact for dual-boot)
3. Mount your partitions and generate hardware configuration:
   ```bash
   sudo nixos-generate-config --root /mnt
   ```

### 2. Configure This Repository

1. Clone this repository to `/mnt/etc/nixos/`:
   ```bash
   git clone https://github.com/your-username/nixos-config /mnt/etc/nixos/
   ```

2. Copy your hardware configuration:
   ```bash
   cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/hardware-configuration.nix.backup
   # Edit the repository's hardware-configuration.nix with your settings
   ```

3. Update configuration:
   - Edit `modules/core.nix`: Set your hostname and username
   - Edit `flake.nix`: Update the hostname in nixosConfigurations
   - Uncomment the hardware-configuration.nix import in `modules/core.nix`

### 3. Install

```bash
sudo nixos-install --flake /mnt/etc/nixos#your-hostname
```

### 4. Post-Installation

1. Set user password:
   ```bash
   sudo passwd your-username
   ```

2. Update system:
   ```bash
   sudo nixos-rebuild switch --flake /etc/nixos#your-hostname
   ```

## Configuration Structure

```
├── flake.nix              # Flake configuration and inputs
├── configuration.nix      # Main configuration file
├── config.fish           # Fish shell configuration
├── modules/
│   ├── core.nix          # Core system configuration
│   ├── gui/
│   │   └── kde.nix       # KDE Plasma configuration
│   └── shell/
│       ├── fish.nix      # Fish shell setup
│       └── kitty.nix     # Kitty terminal configuration
└── hardware-configuration.nix  # Hardware-specific settings
```

## Customization

### Graphics Drivers

Edit `modules/core.nix` to configure your graphics drivers:

- **NVIDIA**: Keep current configuration
- **AMD**: Change `services.xserver.videoDrivers = [ "amdgpu" ];`
- **Intel**: Remove the videoDrivers line and nvidia configuration

### Adding Modules

Create new modules in the `modules/` directory and import them in `configuration.nix`.

### Themes

The configuration uses Catppuccin Macchiato theme. To change:

1. Edit `configuration.nix` to change `catppuccin.flavor`
2. Update Kitty theme in `modules/shell/kitty.nix`

## Useful Commands

### System Management
- `sudo nixos-rebuild switch --flake /etc/nixos#hostname` - Apply configuration changes
- `sudo nixos-rebuild boot --flake /etc/nixos#hostname` - Apply on next boot
- `nix flake update` - Update flake inputs
- `nixos-update` - Custom fish function to pull and rebuild

### Package Management
- `nix search nixpkgs package-name` - Search for packages
- Add packages to `environment.systemPackages` in relevant modules

## Dual Boot Notes

- GRUB is configured with `useOSProber = true` to detect Windows
- Boot timeout is set to 10 seconds
- Default boot option is "saved" (remembers last choice)

## Troubleshooting

### Common Issues

1. **Hardware not detected**: Ensure you've copied the correct hardware-configuration.nix
2. **Graphics issues**: Check driver configuration in `modules/core.nix`
3. **Boot issues**: Verify GRUB configuration and EFI variables

### Getting Help

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [NixOS Options Search](https://search.nixos.org/options)
- [NixOS Discourse](https://discourse.nixos.org/)

## License

This configuration is provided as-is for educational and personal use.
