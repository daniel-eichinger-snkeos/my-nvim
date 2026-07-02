# My nvim

- based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)

## Windows Developer Setup
- install [winget](https://github.com/microsoft/winget-cli)
- install tools and applications:
```bash
winget configure --enable
winget configure -f config.winget.yaml
```

### .NET nvim
- install [rosyln language server](https://github.com/dotnet/roslyn/blob/ef52470b19d31c073f89c604f49a1b4aac4d71e0/src/LanguageServer/Microsoft.CodeAnalysis.LanguageServer/README.md) `dotnet tool install --global roslyn-language-server --prerelease`

> Reference: [ramboe 2026](https://www.youtube.com/watch?v=jJU-ZkQS8PI)
