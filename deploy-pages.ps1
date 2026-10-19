# Deploy Gangling portfolio to GitHub Pages
$ErrorActionPreference = "Stop"
$gh = @(
  "$env:ProgramFiles\GitHub CLI\gh.exe",
  "$env:LocalAppData\GitHub CLI\gh.exe"
) | Where-Object { Test-Path $_ } | Select-Object -First 1

if (-not $gh) { throw "未找到 gh.exe，请先安装 GitHub CLI。" }

Set-Location $PSScriptRoot

Write-Host "1) 检查登录状态..."
& $gh auth status 2>$null
if ($LASTEXITCODE -ne 0) {
  Write-Host "需要登录 GitHub。浏览器打开后按提示完成授权。"
  & $gh auth login --hostname github.com --git-protocol https --web
}

Write-Host "2) 提交当前页面..."
git add index.html README.md .gitignore
git status
git commit -m "Update portfolio: city coverage, retitled switch, interview quotes."
# ignore empty commit
if ($LASTEXITCODE -ne 0) { Write-Host "无新提交或提交跳过，继续推送。" }

$remotes = git remote
if (-not $remotes) {
  Write-Host "3) 创建公开仓库并推送..."
  & $gh repo create gangling-portfolio --public --source=. --remote=origin --push
} else {
  Write-Host "3) 推送到 origin..."
  git push -u origin HEAD
}

$owner = (& $gh api user --jq .login).Trim()
$repo = "gangling-portfolio"
Write-Host "4) 开启 GitHub Pages (main / root)..."
& $gh api "repos/$owner/$repo/pages" -X POST -f build_type=legacy -f "source[branch]=main" -f "source[path]=/" 2>$null
if ($LASTEXITCODE -ne 0) {
  Write-Host "Pages 可能已开启，尝试更新 source..."
  & $gh api "repos/$owner/$repo/pages" -X PUT -f build_type=legacy -f "source[branch]=main" -f "source[path]=/"
}

$url = "https://$owner.github.io/$repo/"
Write-Host ""
Write-Host "完成后几分钟可访问："
Write-Host $url
Write-Host "把该链接发回对话，我可以写进页眉。"
