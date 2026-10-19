# 岗龄 · 产品经理作品集

作者：刘娟

产品岗薪资口径、岗龄路径与去向决策的案例页（课堂原型）。

## 本地预览

```bash
python -m http.server 8765
```

打开 http://127.0.0.1:8765/index.html

## 在线预览（Vercel）

本机网络下 `gh` API 常被拦，可用匿名临时部署：

```powershell
cd "D:\Programs\产品作业"
npx --yes vercel@latest deploy --temporary --yes
```

输出里的 `claimUrl` 用浏览器打开并登录认领后，链接可长期保留。

## GitHub Pages

`github.com` 网页可开，但 CLI 设备码/API 可能超时。推荐：

1. 浏览器新建公开仓库 `gangling-portfolio`
2. 本机推送：

```powershell
cd "D:\Programs\产品作业"
git add index.html README.md deploy-pages.ps1 .gitignore
git commit -m "Update portfolio: city coverage, retitled switch, interview quotes."
git remote add origin https://github.com/<你的用户名>/gangling-portfolio.git
git push -u origin main
```

3. 仓库 Settings → Pages → Source 选 `main` / root

或在 API 可用时运行 `.\deploy-pages.ps1`。