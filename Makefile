download-jars: download-clam-scanner-store download-nginx-lookup-store

create-jar-dir:
	mkdir -p jars

download-clam-scanner-store: create-jar-dir
	wget https://zextras.jfrog.io/artifactory/public-maven-repo/zimbra/zm-clam-scanner-store/22.3.0/zm-clam-scanner-store-22.3.0.jar -P ./jars/

download-nginx-lookup-store: create-jar-dir
	wget https://zextras.jfrog.io/artifactory/public-maven-repo/zimbra/zm-nginx-lookup-store/23.3.0/zm-nginx-lookup-store-23.3.0.jar -P ./jars/