#/bin/bash
sleep 30
for((I=0;I<30;I++))
do
echo $I
sleep 1
done
while true;do

	while true; do
		MONGOCONFIGNUM=$(mongo --host ${MONGOCONFIG}-0.${MONGOCONFIGSVC}.${MY_POD_NAMESPACE} --port 27017 --eval 'rs.status()'|grep 'id'|wc -l 2>/dev/null )
	        if [ $? -ne '0' ];then
	                echo 'internet error'
	                sleep 3
	                continue
	                echo ${MONGOCONFIGNUM}
	        elif [ ${MONGOCONFIGNUM} -lt '3' ];then
	
	        mongo --host ${MONGOCONFIG}-0.${MONGOCONFIGSVC}.${MY_POD_NAMESPACE}  --port 27017 --eval "rs.initiate({_id:\"ConfigDBRepSet\",configsvr:true,members:[{_id:0,host:\"${MONGOCONFIG}-0.${MONGOCONFIGSVC}.${MY_POD_NAMESPACE}:27017\"},{_id:1,host:\"${MONGOCONFIG}-1.${MONGOCONFIGSVC}.${MY_POD_NAMESPACE}:27017\"},{_id:2,host:\"${MONGOCONFIG}-2.${MONGOCONFIGSVC}.${MY_POD_NAMESPACE}:27017\"}]})"
			if [ $? -ne '0' ];then
				sleep 3
				continue
			fi
			#continue
			sleep 3
	                break
	        fi
	        echo 'MONGOCONFIG OK'
	        sleep 5
		break
	done
	while true; do
		MONGOSHARD1NUM=$(mongo --host ${MONGOSHARD1}-0.${MONGOSHARD1SVC}.${MY_POD_NAMESPACE} --port 27017 --eval 'rs.status()'|grep 'id'|wc -l 2>/dev/null )
	        if [ $? -ne '0' ];then
	                echo 'internet error'
	                sleep 3
	                continue
	                echo ${MONGOSHARD1NUM}
	        elif [ ${MONGOSHARD1NUM} -lt '3' ];then
	
	        mongo --host ${MONGOSHARD1}-0.${MONGOSHARD1SVC}.${MY_POD_NAMESPACE}  --port 27017 --eval "rs.initiate({_id:\"Shard1RepSet\",members:[{_id:0,host:\"${MONGOSHARD1}-0.${MONGOSHARD1SVC}.${MY_POD_NAMESPACE}:27017\"},{_id:1,host:\"${MONGOSHARD1}-1.${MONGOSHARD1SVC}.${MY_POD_NAMESPACE}:27017\"},{_id:2,host:\"${MONGOSHARD1}-2.${MONGOSHARD1SVC}.${MY_POD_NAMESPACE}:27017\"}]})"
			if [ $? -ne '0' ];then
				sleep 3
				continue
			fi
			#continue
			sleep 3
	                break
	        fi
	        echo 'MONGOSHARD1 OK'
	        sleep 5
		break
	done
	while true; do
		MONGOSHARD2NUM=$(mongo --host ${MONGOSHARD2}-0.${MONGOSHARD2SVC}.${MY_POD_NAMESPACE} --port 27017 --eval 'rs.status()'|grep 'id'|wc -l 2>/dev/null )
	        if [ $? -ne '0' ];then
	                echo 'internet error'
	                sleep 3
	                continue
	                echo ${MONGOSHARD2NUM}
	        elif [ ${MONGOSHARD2NUM} -lt '3' ];then
	
	        mongo --host ${MONGOSHARD2}-0.${MONGOSHARD2SVC}.${MY_POD_NAMESPACE}  --port 27017 --eval "rs.initiate({_id:\"Shard2RepSet\",members:[{_id:0,host:\"${MONGOSHARD2}-0.${MONGOSHARD2SVC}.${MY_POD_NAMESPACE}:27017\"},{_id:1,host:\"${MONGOSHARD2}-1.${MONGOSHARD2SVC}.${MY_POD_NAMESPACE}:27017\"},{_id:2,host:\"${MONGOSHARD2}-2.${MONGOSHARD2SVC}.${MY_POD_NAMESPACE}:27017\"}]})"
			if [ $? -ne '0' ];then
				sleep 3
				continue
			fi
			#continue
			sleep 3
	                break
	        fi
	        echo 'MONGOSHARD2 OK'
	        sleep 5
		break
	done
	while true; do
		MONGOSHARD3NUM=$(mongo --host ${MONGOSHARD3}-0.${MONGOSHARD3SVC}.${MY_POD_NAMESPACE} --port 27017 --eval 'rs.status()'|grep 'id'|wc -l 2>/dev/null )
	        if [ $? -ne '0' ];then
	                echo 'internet error'
	                sleep 3
	                continue
	                echo ${MONGOSHARD3NUM}
	        elif [ ${MONGOSHARD3NUM} -lt '3' ];then
	
	        mongo --host ${MONGOSHARD3}-0.${MONGOSHARD3SVC}.${MY_POD_NAMESPACE}  --port 27017 --eval "rs.initiate({_id:\"Shard3RepSet\",members:[{_id:0,host:\"${MONGOSHARD3}-0.${MONGOSHARD3SVC}.${MY_POD_NAMESPACE}:27017\"},{_id:1,host:\"${MONGOSHARD3}-1.${MONGOSHARD3SVC}.${MY_POD_NAMESPACE}:27017\"},{_id:2,host:\"${MONGOSHARD3}-2.${MONGOSHARD3SVC}.${MY_POD_NAMESPACE}:27017\"}]})"
			if [ $? -ne '0' ];then
				sleep 3
				continue
			fi
			#continue
			sleep 3
	                break
	        fi
	        echo 'MONGOSHARD3 OK'
	        sleep 5
		break
	done
	while true; do
		MONGONUM=$(mongo --host ${MONGOSVC}.${MY_POD_NAMESPACE} --port 27017 --eval 'sh.status()'|grep state|wc -l 2>/dev/null )
	        if [ $? -ne '0' ];then
	                echo 'internet error'
	                sleep 3
	                continue
	                echo ${MONGONUM}
	        elif [ ${MONGONUM} -lt '3' ];then
	
	        mongo --host ${MONGOSVC}.${MY_POD_NAMESPACE} --port 27017 --eval "sh.addShard(\"Shard1RepSet/${MONGOSHARD1}-0.${MONGOSHARD1SVC}.${MY_POD_NAMESPACE}:27017,${MONGOSHARD1}-1.${MONGOSHARD1SVC}.${MY_POD_NAMESPACE}:27017,${MONGOSHARD1}-2.${MONGOSHARD1SVC}.${MY_POD_NAMESPACE}:27017\")"
		sleep 3
	        mongo --host ${MONGOSVC}.${MY_POD_NAMESPACE} --port 27017 --eval "sh.addShard(\"Shard2RepSet/${MONGOSHARD2}-0.${MONGOSHARD2SVC}.${MY_POD_NAMESPACE}:27017,${MONGOSHARD2}-1.${MONGOSHARD2SVC}.${MY_POD_NAMESPACE}:27017,${MONGOSHARD2}-2.${MONGOSHARD2SVC}.${MY_POD_NAMESPACE}:27017\")"
		sleep 3
	        mongo --host ${MONGOSVC}.${MY_POD_NAMESPACE} --port 27017 --eval "sh.addShard(\"Shard3RepSet/${MONGOSHARD3}-0.${MONGOSHARD3SVC}.${MY_POD_NAMESPACE}:27017,${MONGOSHARD3}-1.${MONGOSHARD3SVC}.${MY_POD_NAMESPACE}:27017,${MONGOSHARD3}-2.${MONGOSHARD3SVC}.${MY_POD_NAMESPACE}:27017\")"
			if [ $? -ne '0' ];then
				sleep 3
				continue
			fi
			#continue
			sleep 3
	                break
	        fi
	        echo 'MONGO OK'
	        sleep 5
		break
	done
sleep 3
done
