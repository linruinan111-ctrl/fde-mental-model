# FDE Mental Model · 技术地图 Skill

面向 FDE（Forward Deployed Engineer）的可复用 **Codex Agent Skill**：让 AI 不只给命令和答案，而是帮助你理解系统为什么运转、组件怎样连接、问题如何定位，以及什么判断必须保留在人手里。

主文件：**[SKILL.md](skills/fde-mental-map/SKILL.md)**。

## 它能做什么？

1. 把新概念放进一张技术地图：服务器、虚拟机、容器、Nginx、数据库、API、AI Agent……
2. 区分网络请求路径、运行部署拓扑、数据依赖和发布流程。
3. 通过真实 FDE 业务案例解释信息如何在组件之间流动。
4. 按层定位故障：不是“系统坏了”，而是“链路的哪一段出了问题”。
5. 说明方案取舍、安全边界、哪些事情 AI 可以做，哪些需要人判断。
6. 给出“学到什么程度可以先停下来”的标准，避免陷入无止境的命令记忆。

## 仓库结构

~~~text
fde-mental-model/
├── README.md
├── .gitignore
├── scripts/
│   ├── install.sh
│   └── verify.sh
└── skills/
    └── fde-mental-map/
        ├── SKILL.md
        ├── agents/
        │   └── openai.yaml
        └── references/
            ├── mental-model-method.md
            ├── glossary.md
            ├── map-examples.md
            └── troubleshooting.md
~~~

## Mac + Codex：3 步安装

**第 1 步**：在 Mac 终端克隆仓库。如果你习惯 GitHub Desktop，也可以用它克隆到本地。

~~~bash
git clone https://github.com/linruinan111-ctrl/fde-mental-model.git
cd fde-mental-model
~~~

**第 2 步**：运行安全安装脚本（不会覆盖已有同名 Skill）。

~~~bash
bash scripts/install.sh
~~~

目标路径是：

~~~text
~/.agents/skills/fde-mental-map/SKILL.md
~~~

这属于个人用户级安装，并非只对当前业务仓库生效。

**第 3 步**：检查文件，并在 Codex 中试用。

~~~bash
bash scripts/verify.sh
~~~

文件检查通过后，重启或刷新 Codex 会话，发送：

~~~text
$fde-mental-map 我是 FDE 初学者，请给我解释服务器、VM、Docker、Nginx 和数据库的关系，先画技术地图再讲命令。
~~~

或者：

~~~text
$fde-mental-map Docker 容器显示 Up，但是浏览器打不开页面。请帮我从 DNS、网络、代理、端口映射、应用状态分层排查，先不要修改生产配置。
~~~

或者：

~~~text
$fde-mental-map 帮我解释 Windows Agent、Gateway、Worker、Playwright 怎样通过心跳领取任务；哪些组件在云端、哪些在客户内网？
~~~

## 如何更新 Skill？

仓库更新后，可重新克隆或执行 git pull。已经安装过的目录默认不会自动被覆盖。建议在新版本通过检查后，手动比较、备份并替换用户级目录。

原因：Skill 会影响 Codex 的回答方式。不要在未审核的情况下覆盖已经稳定使用的指令。

## 为什么它是一张“地图”而不是术语表？

不要把所有名词强行串在一条线上。例如：

**请求关系**

~~~text
用户 --HTTPS--> Nginx --代理--> 应用 --SQL--> 数据库
                                  |
                                  +--HTTPS--> Model API
~~~

**运行包含关系**

~~~text
物理机/云资源 -> VM（可选） -> Linux -> Docker（可选） -> 容器 -> 应用进程
~~~

**部署交付关系**

~~~text
代码 -> Git/PR -> CI -> 构建 -> CD -> 目标机器运行新版本
~~~

三张图对应完全不同的问题，不能混用。

## 安全边界

这是解释和分析技能，不是自动监控程序；它不会在后台持续维护技术知识库，也不会自动给 Codex 增加 GitHub、内网、生产服务器权限。

- 对项目架构未核实的部分标记“示意 / 待确认”。
- 不向外公开 Token、Cookie、API Key、数据库密码、客户数据和私钥。
- 默认只读排查；更改生产配置、部署、数据库前需要明确授权。
- AI 可以负责低频命令、样板代码和信息整理；人必须负责风险、权限、方案选择和验收。

## 相关资料

- [教学方法与停止标准](skills/fde-mental-map/references/mental-model-method.md)
- [术语词典](skills/fde-mental-map/references/glossary.md)
- [示例技术地图](skills/fde-mental-map/references/map-examples.md)
- [排障手册](skills/fde-mental-map/references/troubleshooting.md)

欢迎在自己的学习中逐渐补充案例，但不要把客户资料或公司机密提交到公开仓库。
