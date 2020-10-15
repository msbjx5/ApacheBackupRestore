#!/usr/bin/env bash

# verificando se o usuario e root
if [ "$EUID" -ne 0 ]; then
        echo "Desculpe, você precisa estar logado com usuário root"
		exit 1
fi

# criando a variavel data para timestamp do arquivo de backup
DATE=$(date +%d%m%y_%H%M%S)

# definindo as variaveis de log
DESTDIR2=/var/log
LOGRESTORE="RESTOREWebServerBackup"-"$DATE".log

# instrucoes para o usuario
echo
echo
echo
echo -e "Este script irá restaurar o backup selecionado\nÉ muito importante que você faca um backup do estado atual."
echo
echo "Caso você não tenha um backup do estado atual recomendamos sair e rodar um backup manualmente."
echo "Caso voce opte por sair e fazer um backup manual digite CTRL+C e digite o comando abaixo:"
echo
echo "sudo /bkp/script/./WebServerBackup.sh"
echo
echo
echo "E então executar este script novamente"
echo
echo
echo "Selecione um backup da lista abaixo para ser restaurado"
echo
# criacao de variavel com os arquivos de backup da pasta /bkp e procedimento de restore do arquivo selecionado
LISTARESTORE=$(ls /bkp/*.tar.gz)
# contador
i=1
echo
# criacao de um laco para verificar os arquivos dentro dos arquivos de backup
for j in $LISTARESTORE
do
echo "$i.$j"
ARQRESTORE[i]=$j
i=$(( i + 1 ))
done

# gerando o arquivo de log
exec &> >(tee -a /$DESTDIR2/$LOGRESTORE)
    exec 2>&1

# descompactacao do arquivo escolhido pelo usuario
echo
echo "Digite o numero do arquivo escolhido ou CTRL+C para abortar"
read input
/bin/tar -xpzvf  ${ARQRESTORE[$input]} -C /

# input no log de exito ou erro
if [ $? = 0 ];
		then
			echo "RESTORE REALIZADO COM SUCESSO" >> /$DESTDIR2/$LOGRESTORE
		else
			echo "ERRO RESTORE NAO REALIZADO" >> /$DESTDIR2/$LOGRESTORE
	fi

echo
echo "O arquivo selecionado foi restaurado"
echo