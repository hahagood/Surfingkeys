#!/bin/bash

# 1. 记录当前分支名
default_branch="my-changes"
current_branch=$(git rev-parse --abbrev-ref HEAD)

# 2. 切换到 master 分支
if [ "$current_branch" != "master" ]; then
  git checkout master
fi

# 3. 拉取上游最新 master
git fetch upstream
git merge upstream/master

# 4. 推送最新 master 到你自己的 fork
git push origin master

# 5. 切换回你原来的开发分支
if [ "$current_branch" != "master" ]; then
  git checkout "$current_branch"
  # 6. 合并 master 的最新内容到当前分支
  git merge master
  # 7. 推送当前分支到 fork
  git push origin "$current_branch"
fi

echo "已同步上游仓库，并将 master 及当前分支推送到 fork！" 