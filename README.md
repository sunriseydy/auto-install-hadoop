# auto-install-hadoop
Auto install hadoop

Ubuntu 一键安装 Hadoop

### 系统需求
Ubuntu16.04 64位

### 使用方法

登陆Ubuntu后在终端中输入以下命令：
`wget -O start.sh https://github.com/sunriseydy/auto-install-hadoop/raw/master/start.sh && sudo bash start.sh`

#### 新增安装 Hadoop 2.7.5 版本

登陆Ubuntu后在终端中输入以下命令：

`wget -O start-2.7.5.sh https://github.com/sunriseydy/auto-install-hadoop/raw/master/start-2.7.5.sh && sudo bash start-2.7.5.sh`

输入你登陆的用户名密码即可。
等待脚本运行结束。期间需要联网！需要联网！需要联网！（需要下载 JDK 和 hadoop）

![](https://github.com/sunriseydy/auto-install-hadoop/raw/master/screenshot_1.png)

若最后出现如图所示表示 hadoop 安装成功

接着就可以用 ssh 登陆你的 hadoop 用户(初始密码为 hadoop)

##### `hadoop`安装路径
`/usr/local/hadoop`

##### `hadoop` 运行命令
`/usr/local/hadoop/bin/hadoop xxxxxxxxxxxxx`
##### `java` 安装路径
`/usr/lib/jvm/java-8-openjdk-amd64`

### 相关教程
##### hadoop 3.0.0 官方文档
[ Apache Hadoop 3.0.0 : Setting up a Single Node Cluster.](http://hadoop.apache.org/docs/r3.0.0/hadoop-project-dist/hadoop-common/SingleCluster.html " Apache Hadoop 3.0.0 : Setting up a Single Node Cluster.")
##### Hadoop 2.7.5 官方文档
[Apache Hadoop 2.7.5](http://hadoop.apache.org/docs/r2.7.5/ "Apache Hadoop 2.7.5")

##### 安装 JDK 教程
[在Linux[Ubuntu CentOS]上安装配置JDK](https://blog.sunriseydy.top/technology/server-blog/server/linux-ubuntu-centos-install-jdk/ "在Linux[Ubuntu CentOS]上安装配置JDK")

##### Ubuntu 开启 SSH 证书登陆教程
[Ubuntu配置ssh并实现Putty密钥登陆、禁止密码登陆、更改ssh端口](https://blog.sunriseydy.top/technology/server-blog/server/ubuntupeizhisshbingshixianputtymiyaodenglujinzhimimadenglugenggaisshduankou/ "Ubuntu配置ssh并实现Putty密钥登陆、禁止密码登陆、更改ssh端口")


### 已知 Bug
在shell脚本中虽然已经设置了 Java 的环境变量，但当时并没有生效，需要重新登陆才行
