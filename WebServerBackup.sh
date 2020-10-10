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
