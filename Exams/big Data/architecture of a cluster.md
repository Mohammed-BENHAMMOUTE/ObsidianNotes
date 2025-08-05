+ Network architecture of a cluster:
is composed of rack switches that are fast low latency, and connect nodes inside of the same rack.

for communication between nodes in different racks we use a switch, so the traffic goes from the node to the rack switch and then to the global switch , and then again in to the destination rack switch and finally into the destination node.

+ Distributed processing with Hadoop:

1. <mark style="background: #BBFABBA6;">Processing layer</mark> 
it is composed of 3 layers, the processing layer which is composed of **Apache Spark**,and **map reduce**.

Apache Spark is used for in-memory data processing.
while **mapreduce**, is the original framework, that splits the process into map and then reduce.

2. <mark style="background: #FFF3A3A6;">Resource management layer</mark>:
This layer manages and Allocates computing ressources across the cluster.
+ YARN: yet another ressource negotiator
+ Apache Mesos: cluster manager
+ spark standalone: spark built in cluster manager for simpler deployments.

3. <mark style="background: #ADCCFFA6;">Storage Layer</mark>:

+ HDFS : Hadoop distributed file system.
+ Amazon S3 : Cloud-based storage manager.
+ Apache Kudu


# HDFS

Is a filesystem written in Java, Based on Google filesystem
![[Pasted image 20250524050115.png]]

built on top of the native filesystems ext3, ext4 or xfs.


-> HDFS performs best with a "modest" number of large files:
	+ millions of files with 100MB or more.

-> Files are split into blocks, the data extracted from each files will have 3 replicas.

-> Files in HDFS are "write once, read-many": we try to minimize the number of writes because they are more expensive.


# HDFS Architecture:
Master/Slave architecture: 
Master: NameNode
+ manage the file system namespace and metadata.
+ Regulates client access to files.

Slave: DataNode
+ many per cluster
+ manages storage attached to the nodes
+ periodically reports status to NameNode


**HDFS Blocks**: 
an HDFS Blocks is a part of the data that was split from the source file into different blocks ans that will be distributed between multiple dataNode.

**HDFS Replication**:
Blocks of data that are replicated to multiple nodes:

+ The nameNode must be Highly Available, the nameNode is considered a single point of failure, if the nameNode is down , then all of our system is down. we cant access the files or the filesystem
+ that's why we must have two nameNodes, one in the Available state, and the second in the StandBy state.


**Map reduce:**
