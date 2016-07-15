#!/bin/bash

#ejabberdctl需要添加到PATH中，通过dmg文件安装ejabber，默认是不会在环境变量中的。需要手动添加到环境变量中。
# vi ~/.bash_profile
# 将后面的添加到文件里面 export PATH=${PATH}:/Applications/ejabberd-16.04/bin
# 执行后面的命令，让环境变量立即生效 source ~/.bash_profile

# 需要自己来修改，可以在 /Applications/ejabberd-16.04/conf/ejabberd.yml 这个文件中host查看

host="chatimswift.com"
# 密码
password="123456"
# 用户名
userList=("abbott" "abraham" "chenwei" "baobei" "barry" "hinson" "carter" "jerry" "tom" "trista")

for username in ${userList[*]}; do
	ejabberdctl register $username $host $password
done

