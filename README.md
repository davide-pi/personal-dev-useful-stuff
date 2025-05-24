# personal-dev-useful-stuff
[![Terminal Settings](https://github.com/davide-pi/personal-dev-useful-stuff/actions/workflows/validate-terminal-settings.yml/badge.svg?branch=main)](https://github.com/davide-pi/personal-dev-useful-stuff/actions?query=workflow%3A%22CI+Terminal+Settings%22)
[![Terminal Icons](https://github.com/davide-pi/personal-dev-useful-stuff/actions/workflows/validate-terminal-icons.yml/badge.svg?branch=main)](https://github.com/davide-pi/personal-dev-useful-stuff/actions?query=workflow%3A%22CI+Terminal+Icons%22)

This repository contains some useful (_at least for me_) stuff to work as a dev on Windows, including PowerShell and Windows Terminal customizations.

## Repository Structure

- `pwsh/` – PowerShell profile and a list of useful modules
  - `Microsoft.PowerShell_profile.ps1`: Loads custom modules (e.g., posh-git) and customizes the prompt
  - `useful-modules.md`: List of recommended PowerShell modules
- `terminal/` – Windows Terminal settings and icons
  - `settings.json`: Custom keybindings, profiles, and UI tweaks
  - `icons/`: Terminal profile icons (e.g., `csharp.png`)

## Usage

### PowerShell Profile
1. Copy or symlink `pwsh/Microsoft.PowerShell_profile.ps1` to your PowerShell profile location (see `$PROFILE` in PowerShell).
2. Ensure required modules (e.g., `posh-git`) are installed. See `pwsh/useful-modules.md` for recommendations.

### Windows Terminal Settings
1. Open Windows Terminal settings.
2. Replace or merge your `settings.json` with the one in `terminal/settings.json`.
3. Place any icons you want to use in the `icons/` folder and update the icon paths in `settings.json` as needed.

## Customization Examples

- The PowerShell profile customizes the prompt with a timestamp and colors using posh-git.
- The Windows Terminal settings include profiles for PowerShell, Git Bash, C# REPL, and more, with custom icons.

## Contributing
Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

## License
This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
