#!/bin/bash
#Download JDK and Hadoop, then insatll then and run hadoop's example.

### Please set the jdk and hadoop download url
JDK_DOWNLOAD_URL="https://download.java.net/java/GA/jdk12/GPL/openjdk-12_linux-x64_bin.tar.gz"
Hadoop_DOWNLOAD_URL="http://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-3.1.2/hadoop-3.1.2.tar.gz"


### Do not edit the following sections.

[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must run this as root or sudo.${CEND}"; exit 1; }

# If you need to use again, please del all old folder and user.
# rm -rf /home/hadoop
# userdel -rf hadoop

#Create user hadoop to use. 
#Thanks for sunriseydy 's suggestion

echo "Create hadoop user,the password is hadoop."
useradd -m hadoop -s /bin/bash
echo hadoop:hadoop|chpasswd

# Edit /etc/sudoers to open wheel group then add user hadoop into wheel group

sed -i 's/#%wheel	ALL=(ALL)	ALL/%wheel	ALL=(ALL)	ALL/g' /etc/sudoers
usermod -a -G wheel hadoop

echo "Set the authorized_keys for user hadoop."
sudo -u hadoop ssh-keygen -t rsa -P '' -f /home/hadoop/.ssh/id_rsa
sudo -u hadoop touch /home/hadoop/.ssh/authorized_keys
sudo -u hadoop cat /home/hadoop/.ssh/id_rsa.pub >> /home/hadoop/.ssh/authorized_keys
sudo -u hadoop chmod 0600 /home/hadoop/.ssh/authorized_keys


workpath=/home/hadoop/software
echo "Set the software path: ${workpath}"
mkdir -p ${workpath}
cd ${workpath}


echo "Install the base tools"
yum -y install wget tar ssh sshd pdsh rsync


echo "Try to download JDK."
wget -t 3 -T 30 --no-check-certificate -O "${workpath}/jdk.tar.gz" "${JDK_DOWNLOAD_URL}"
echo "Try to download Hadoop."
wget -t 3 -T 30 --no-check-certificate -O "${workpath}/hadoop.tar.gz" "${Hadoop_DOWNLOAD_URL}"


echo "Unzip JDK and Hadoop."
tar -xvf ${workpath}/jdk.tar.gz
tar -xvf ${workpath}/hadoop.tar.gz

echo "Rename their folder."
mv ${workpath}/jdk-* ${workpath}/jdk
mv ${workpath}/hadoop-* ${workpath}/hadoop

echo "Set environment variables"
export JAVA_HOME=${workpath}/jdk
export HADOOP_HOME=${workpath}/hadoop
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$CLASSPATH:`$HADOOP_HOME/bin/hadoop classpath`
export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$JAVA_HOME/bin:${PATH}
export PDSH_RCMD_TYPE=ssh
echo "export JAVA_HOME=${workpath}/jdk" >> /home/hadoop/.bashrc
echo "export HADOOP_HOME=${workpath}/hadoop" >> /home/hadoop/.bashrc
echo "export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar" >> /home/hadoop/.bashrc
echo "export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$CLASSPATH:`$HADOOP_HOME/bin/hadoop classpath`" >> /home/hadoop/.bashrc
echo "PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$JAVA_HOME/bin:${PATH}" >> /home/hadoop/.bashrc
echo "PDSH_RCMD_TYPE=ssh" >> /home/hadoop/.bashrc
source /home/hadoop/.bashrc

chown -R hadoop:hadoop /home/hadoop

# The set environment will lost when user used command sudo, so i have to use other way
#echo "Start to test hadoop by example"
#sudo -u hadoop hadoop version
#sudo -u hadoop mkdir ${workpath}/test
#sudo -u hadoop cd ${workpath}/test
#sudo -u hadoop mkdir input
#sudo -u hadoop cp ${workpath}/hadoop/etc/hadoop/*.xml input
#sudo -u hadoop jar ${workpath}/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar grep input output 'dfs[a-z.]+' grep input output 'dfs[a-z.]+'
#sudo -u hadoop cat output/*


echo "Start to test hadoop by example"
su hadoop << TEST
hadoop version
mkdir ${workpath}/test
cd ${workpath}/test
mkdir input
cp ${workpath}/hadoop/etc/hadoop/*.xml input
hadoop jar ${workpath}/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar grep input output 'dfs[a-z.]+' grep input output 'dfs[a-z.]+'
cat output/*
TEST