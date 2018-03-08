# auto-install-hadoop
Auto install hadoop

### 系统需求
Ubuntu16.04 64位

### 使用方法

登陆Ubuntu后在终端中输入以下命令：
`wget -O start.sh https://dl.sunriseydy.top/start.sh && sudo bash start.sh`


输入你登陆的用户名密码即可。
等待脚本运行结束。期间需要联网！需要联网！需要联网！（需要下载 JDK 和 hadoop）

![](https://github.com/sunriseydy/auto-install-hadoop/raw/master/screenshot_1.png)

若最后出现如图所示表示 hadoop 安装成功

接着就可以用 ssh 登陆你的 hadoop 用户

##### `hadoop`安装路径
`/usr/local/hadoop`

##### `hadoop` 运行命令
`bash /usr/local/hadoop/bin/hadoop xxxxxxxxxxxxx`
##### `java` 安装路径
`/usr/lib/jvm/java-8-openjdk-amd64`

### 已知 Bug
在shell脚本中虽然已经设置了 Java 的环境变量，但当时并没有生效，需要重新登陆才行
