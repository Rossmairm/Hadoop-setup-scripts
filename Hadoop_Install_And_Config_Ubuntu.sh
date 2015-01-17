sudo apt-get install python-software-properties
sudo add-apt-repository ppa:ferramroberto/java
sudo apt-get update

sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java7-installer
java -version
sudo update-java-alternatives -s java-7-oracle
sudo apt-get install oracle-java7-set-default

ssh-keygen -t rsa -P ""
cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
sudo apt-get install openssh-server
ssh localhost
yes

sudo mv /home/user/Downloads/hadoop-1.2.1.tar.gz /usr/local
sudo tar xzf hadoop-1.2.1.tar.gz
sudo mv hadoop-1.2.1 hadoop
sudo chown -R user hadoop

export HADOOP_HOME=/usr/local/hadoop
export JAVA_HOME=/usr/lib/jvm/java-7-oracle
unalias fs &> /dev/null
alias fs="hadoop fs"
unalias hls &> /dev/null
alias hls="fs -ls"
export PATH=$PATH:$HADOOP_HOME/bin

nano /usr/local/hadoop/conf/hadoop-env.sh
change
# The java implementation to use.  Required.
# export JAVA_HOME=/usr/lib/j2sdk1.5-sun
to
# The java implementation to use.  Required.
export JAVA_HOME=/usr/lib/jvm/java-7-oracle
Ctrl+O
Ctrl+x

sudo chown user /app/hadoop/tmp

nano /usr/local/hadoop/conf/core-site.xml
between <configuration> and </configuration> put

<property>
  <name>hadoop.tmp.dir</name>
<value>/app/hadoop/tmp</value>
  <description>A base for other temporary directories. 
  </description>
</property>

<property>
  <name>fs.default.name</name>
  <value>hdfs://localhost:54310</value>
  <description>The name of the default file system.  A URI whose
  scheme and authority determine the FileSystem implementation.  The
  uri's scheme determines the config property (fs.SCHEME.impl) naming
  the FileSystem implementation class.  The uri's authority is used to
  determine the host, port, etc. for a filesystem.</description>
</property>

Ctrl+O
Ctrl+x

nano /usr/local/hadoop/conf/mapred-site.xml
between <configuration> and </configuration> put

<property>
  <name>mapred.job.tracker</name>
  <value>localhost:54311</value>
  <description>The host and port that the MapReduce job tracker runs
  at.  If "local", then jobs are run in-process as a single map
  and reduce task.
  </description>
</property>

Ctrl+O
Ctrl+x

nano /usr/local/hadoop/conf/hdfs-site.xml
between <configuration> and </configuration> put

<property>
  <name>dfs.replication</name>
  <value>1</value>
  <description>Default block replication.
  The actual number of replications can be specified when the file is created.
  The default is used if replication is not specified in create time.
  </description>
</property>

Ctrl+O
Ctrl+x

/usr/local/hadoop/bin/hadoop namenode -format

/usr/local/hadoop/bin/start-all.sh

mkdir /tmp/gutenberg
move files into this folder

bin/hadoop dfs -copyFromLocal /tmp/gutenberg /user/hduser/gutenberg

bin/hadoop jar hadoop*examples*.jar wordcount /user/hduser/gutenberg /user/hduser/gutenberg-output

