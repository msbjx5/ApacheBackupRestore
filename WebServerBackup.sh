# definindo a shell de execucao
#!/usr/bin/env bash

# verificando se o usuario e root
if [ "$EUID" -ne 0 ]; then
        echo "Desculpe, você precisa estar logado com usuário root"
		exit 1
fi

clear
# identificando o SO
# e definida a varivael SO, cat para mostraro conteudo do arquivo, grep para pesquisar pela string, cut para omitir do resultado a string NAME=" em seguida para omitir o sinal de " e em seguida para omitir a string Linux
SO=$(cat /etc/*release | grep ^NAME | cut -d "=" -f2 | cut -d '"' -f2 | cut -d " " -f1)

# criando a variavel data para timestamp do arquivo de backup
DATE=$(date +%d%m%y_%H%M%S)

# criando as variaveis do backup
DESTDIR1=/bkp
BKP="WebServerBackup"-"$DATE"

# criando as variaveis do log
DESTDIR2=/var/log
LOG=BACKUPWebServer-"$DATE".log

# gerando o arquivo de log
exec &> >(tee -a /$DESTDIR2/$LOG)
    exec 2>&1

# procedimento de backup baseado no SO identificado
if [ $SO = Debian ];
    then
        echo -e "Sistema operacional Debian detectado\nIniciando o backup do Apache2"
        echo
        /bin/tar -zcvf /$DESTDIR1/"$BKP".tar.gz /etc/apache2 /var/log/apache2 /var/www
	if [ $? = 0 ];
		then
			echo "BACKUP REALIZADO COM SUCESSO" >> /$DESTDIR2/"$LOG"
		else
			echo "ERRO BACKUP NAO REALIZADO" >> /$DESTDIR2/"$LOG"
	fi
elif [ $SO = CentOS ];
    then
        echo -e "Sistema operacional CentOS detectado\nIniciando o backup do HTTPD"
        echo
        /usr/bin/tar -zcvf /$DESTDIR1/"$BKP".tar.gz /etc/httpd /var/log/httpd /var/www
    if [ $? = 0 ];
		then
			echo "BACKUP REALIZADO COM SUCESSO" >> /$DESTDIR2/$LOG
		else
			echo "ERRO BACKUP NAO REALIZADO" >> /$DESTDIR2/$LOG
	fi
else
    echo -e "ESTE SCRITP NAO RODA NO SEU SISTEMA OPERACIONAL\nENTRE EM CONTATO COM O SUPORTE"
    echo
fi