1.    git init  创建版本库    折腾项目的文件夹

2.    git add、git commit、git status、git log操作版本库
2.1  git add       往清单里面放内容      git add 1.txt  		 git add . 可以提交整个文件夹
2.2  git status    查看清单的内容         
2.3  git commit 提交仓库                   git commit -m "version message"
2.4  git log        查看版本库的内容      git log命令拓展 git log --pretty=oneline   一行显示版本   HEAD表示当前版本        log之后如果出现冒号  可以按q退出

3.    git版本库回退操作
3.1  git reset          还原版本        git reset --hard 放入版本 HEAD^/HEAD~数字
3.2  git reset          版本指定        git reset --hard 版本哈希值
3.3  git reflog        查看命令历史  使用哈希值就可以回退到指定版本

4.    git撤销和删除
4.1  git checkout   在没有add之前回退到上个add的版本  git checkout --1.txt
4.2  已经add之后   用git reset HEAD 1.txt可以从清单中去除1.txt
4.3  rm 3.txt     删除文件     误删的处理  git reset HEAD 1.txt 之后再使用git checkout -- 1.txt

5.    连接github，打开终端创建ssh密钥  ssh-keygen -t rsa -C "your email"
      运行后会生成.ssh文件夹  id_rsa是私钥    id_rsa.pub是公钥   将公钥放在git的设置里面就可以配对了

6.    gitHub上创建仓库
7.    使用git remote add origin 仓库地址提交本地仓库
8.    git pull --rebase origin master获取远程仓库与本地同步合并
9.    git push -u origin master把本地库的内容推送到远程



git的其他操作
10.	git clone 地址   克隆项目
11.	git branch 分支名      创建分支   树状结构
	git checkout 分支名   切换到分支
	git checkout master  切回主版本
	git branch查看分支
	git merge 分支名 合并分支
	git branch -D name删除分支
12.	解决分支冲突
	git checkout -b 分支名 创建并切换到分支
	用git add 再git commit可以强制合并
13.	git Fast forward模式    合并后分支痕迹会消失
	禁用Fast forward模式合并  git merge --no-ff -m "msg" 分支名
14.	临时储存分支信息
	git stash 临时储存工作区
	git stash list查看临时储存工作区
	git stash apply恢复临时储存工作区
	git stash drop清空临时储存工作区
	git stash pop恢复并清空临时储存工作区
15.	强行删除分支
	git branch -D name
	