# omp-mojada-theme-main

[English](README.md)

这是一个用于 Windows Terminal + PowerShell 7 的个人美化配置仓库，基于 Oh My Posh。

当前主题以 `jandedobbeleer` 风格为基础做了定制：保留彩色 Powerline 提示符，并调整了 Python segment，使 conda 或 virtualenv 激活后可以直接在提示符中显示环境名，即使当前目录是用户主目录 `~`。

## Oh My Posh 美化说明

Oh My Posh 是一个跨平台 prompt 美化工具，可以根据当前终端上下文动态显示信息，例如：

- 当前用户名和目录
- Git 分支、远程同步状态、工作区改动
- Node.js、Python、Go 等语言环境
- conda 或 virtualenv 虚拟环境
- 命令执行耗时
- 上一条命令是否成功
- 电池电量、当前时间、当前 Shell

这套配置主要做了几件事：

- 使用 Oh My Posh 接管 PowerShell 提示符样式
- 使用 `jandedobbeleer` 风格作为基础主题
- 修改 Python segment，让 conda 环境名可以稳定显示
- 使用 PSReadLine 增强历史搜索、预测提示和 Tab 补全
- 使用 Terminal-Icons 给文件列表增加图标
- 保留一份 Windows Terminal 配置作为字体和配色参考

如果提示符里出现乱码、方块或图标缺失，通常是字体没有配置好。建议在 Windows Terminal 中使用 Nerd Font，例如 `CaskaydiaCove Nerd Font` 或 `MesloLGM Nerd Font`。

官方入口：

- Oh My Posh 官网：<https://ohmyposh.dev/>
- 官方主题列表：<https://ohmyposh.dev/docs/themes>

## 主题推荐

Oh My Posh 官方内置了很多主题，可以从官方主题列表预览效果。当前仓库默认使用的是改造后的 `jandedobbeleer` 风格。

推荐优先尝试这些主题：

| 主题 | 适合场景 |
| --- | --- |
| `jandedobbeleer` | 信息完整，Git、语言环境、状态提示都比较清楚，适合作为日常开发默认主题。 |
| `powerlevel10k_modern` | 接近 Powerlevel10k 的现代风格，信息密度高，适合喜欢完整状态栏的人。 |
| `powerlevel10k_rainbow` | 色彩更明显，区块感强，适合想快速区分不同状态的人。 |
| `1_shell` | 风格简洁，常用信息清楚，适合不想太复杂但仍要 Powerline 效果的人。 |
| `clean-detailed` | 清爽、克制，适合长期写代码时减少视觉负担。 |
| `catppuccin_macchiato` / `catppuccin_mocha` | 配色柔和，适合喜欢 Catppuccin 色系的人。 |
| `robbyrussell` | 简单经典，但默认信息较少；如果要显示 conda，需要额外加入 Python segment。 |

如果没有安装 Nerd Font，可以优先选择名字里带 `minimal` 的主题。官方说明中也提到，`minimal` 主题通常不依赖 Nerd Font。

切换到某个主题可以先导出一份本地配置：

```powershell
oh-my-posh config export --config jandedobbeleer --output "$HOME\.config\oh-my-posh\theme.omp.json"
```

然后在 `$PROFILE` 中加载它：

```powershell
oh-my-posh init pwsh --config "$HOME\.config\oh-my-posh\theme.omp.json" | Invoke-Expression
```

如果希望新主题继续显示 conda 环境，需要确认主题里有 `python` segment，并且启用了类似下面的配置：

```json
{
  "options": {
    "display_mode": "environment",
    "fetch_virtual_env": true,
    "home_enabled": true
  },
  "template": "  {{ .Venv }} ",
  "type": "python"
}
```

## 文件说明

| 文件 | 用途 |
| --- | --- |
| `mojada.omp.json` | Oh My Posh 主题文件，已配置 Python segment 来显示 conda/venv 环境。 |
| `mojada-config.ps1` | PowerShell profile 模板，包含 Oh My Posh、PSReadLine、Terminal-Icons、posh-git 和常用别名。 |
| `setup.ps1` | 安装脚本，会复制主题并安全更新 `$PROFILE`。 |
| `settings.json` | Windows Terminal 配置参考。不要直接覆盖本机配置，建议先对比后再合并。 |

## 环境要求

- Windows 10 或更高版本
- PowerShell 7
- Windows Terminal
- Nerd Font 字体，例如 `CaskaydiaCove Nerd Font` 或 `MesloLGM Nerd Font`
- Oh My Posh

可选模块：

- `Terminal-Icons`
- `PSReadLine`
- `posh-git`

## 安装

在本仓库目录中打开 PowerShell，执行：

```powershell
.\setup.ps1
```

如果还想同时安装或更新可选模块：

```powershell
.\setup.ps1 -InstallModules
```

安装脚本会把主题复制到：

```text
%USERPROFILE%\.config\oh-my-posh\mojada.omp.json
```

脚本修改 PowerShell profile 前会自动备份原文件，备份路径类似：

```text
%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1.bak-YYYYMMDD-HHMMSS
```

安装后重启 PowerShell，或者执行：

```powershell
. $PROFILE
```

## Conda 环境显示

这个主题会通过 Oh My Posh 的 Python segment 显示当前激活的 conda 或 virtualenv 环境名。

推荐先关闭 conda 自带的 prompt 修改：

```powershell
conda config --set changeps1 False
```

然后激活环境：

```powershell
conda activate yolo26
```

激活后，提示符中应该会出现黄色 Python 区块，并显示环境名，例如 `yolo26`。

如果想确认 conda 是否真的激活成功，可以执行：

```powershell
$env:CONDA_DEFAULT_ENV
```

## PSReadLine 快捷键

`mojada-config.ps1` 启用了按输入前缀搜索历史命令：

```powershell
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
```

用法示例：

1. 先输入命令开头，例如 `conda`
2. 按 `↑` 或 `↓`
3. PowerShell 会在历史记录中搜索以 `conda` 开头的命令

这比普通的上下键翻历史更适合经常重复使用 `conda activate ...`、`git ...`、`npm ...` 等命令。

## 手动配置 `$PROFILE`

如果不想运行安装脚本，也可以手动把主题文件放到：

```text
%USERPROFILE%\.config\oh-my-posh\mojada.omp.json
```

然后在 `$PROFILE` 中加入：

```powershell
oh-my-posh init pwsh --config "$HOME\.config\oh-my-posh\mojada.omp.json" | Invoke-Expression
```

查看 `$PROFILE` 路径：

```powershell
$PROFILE
```

打开 `$PROFILE`：

```powershell
notepad $PROFILE
```

## Windows Terminal 设置

`settings.json` 是旧配置中保留下来的 Windows Terminal 设置参考。

不要直接用它覆盖当前 Windows Terminal 配置，尤其要注意：

- 字体名称
- 配色方案
- PowerShell profile 的 GUID
- 默认启动 profile

更推荐把需要的字体、配色和启动项单独合并到你当前的 Windows Terminal 设置中。

## 回滚

如果安装后想恢复旧配置，可以找到安装脚本生成的备份文件：

```text
Microsoft.PowerShell_profile.ps1.bak-YYYYMMDD-HHMMSS
```

然后把它改回：

```text
Microsoft.PowerShell_profile.ps1
```
