#/bin/bash
if [ $# -eq 1 ];then
SRC_BRANCH=$1
DST_BRANCH=dev
elif [ $# -eq 2 ];then
SRC_BRANCH=$1
DST_BRANCH=$2
else
echo "Usage: $0 <src_branch> [dst_branch]"
exit -1
fi
echo "Merging -- branch[$1] to $DST_BRANCH"
git stash
echo "Merging -- git fetch"
git fetch
echo "Merging -- git checkout $SRC_BRANCH"
git checkout $SRC_BRANCH
echo "Merging -- git reset --hard origin/$SRC_BRANCH"
git reset --hard origin/$SRC_BRANCH
echo "Merging -- git checkout $DST_BRANCH"
git checkout $DST_BRANCH
echo "Merging -- git reset --hard origin/$DST_BRANCH"
git reset --hard origin/$DST_BRANCH
echo "Merging -- git merge --no-ff $SRC_BRANCH"
git merge --no-ff refs/heads/$SRC_BRANCH
echo "Merging -- git commit --amend"
git commit --amend
