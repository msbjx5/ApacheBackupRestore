# definindo a shell de execucao
#!/usr/bin/env bash

# verificando se o usuario e root
if [ "$EUID" -ne 0 ]; then
        echo "Desculpe, você precisa estar logado com usuário root"
        exit 1
fi

# identificando o SO
# e definida a varivael SO, cat para mostraro conteudo do arquivo, grep para pesquisar pela string, cut para omitir do resultado a string NAME=" em seguida para omitir o sinal de " e em seguida para omitir a string Linux
SO=$(cat /etc/*release | grep ^NAME | cut -d "=" -f2 | cut -d '"' -f2 | cut -d " " -f1)

# criando a variavel data para timestamp do arquivo de instalacao
DATE=$(date +%d%m%y_%H%M%S)

# definindo as variaveis de log
DESTDIR2=/var/log
LOG=CRONWebServerBackup-"$DATE".log

# gerando o log
exec &> >(tee -a /$DESTDIR2/$LOG)
    exec 2>&1

# criando os diretorios necessarios
echo "Criando os diretórios necessários"
mkdir -p /bkp/script

# movendo o script para o diretorio de execucao
echo "Movendo os scripts para os diretórios de execução"
cp *.sh /bkp/script
cd /bkp/script
chmod 700 *.sh

# adicionando o script no cron
echo "Adicionando o script de backup no cron"

# procedimento de agendamento no cron baseado no SO identificado
if [ $SO = Debian ];
    then
        echo -e "Sistema operacional Debian detectado\nAdicionando tarefa no cron"
        echo "0 23 * * * /bin/bash /bkp/script/WebServerBackup.sh" | tee -a /var/spool/cron/crontabs/root
    if [ $? = 0 ];
        then
            echo "AGENDAMENTO REALIZADO COM SUCESSO" >> /$DESTDIR2/$LOG
        else
            echo "ERRO AGENDAMENTO NAO REALIZADO" >> /$DESTDIR2/$LOG
        fi
    elif [ $SO = CentOS ];
        then
            echo -e "Sistema operacional CentOS detectado\nAdicionando a tarefa no Cron"
            echo "0 23 * * * /bin/bash /bkp/script/WebServerBackup.sh" | tee -a /var/spool/cron/root
    if [ $? = 0 ];
        then
            echo "AGENDAMENTO REALIZADO COM SUCESSO" >> /$DESTDIR2/$LOG
        else
                echo "ERRO AGENDAMENTO NAO REALIZADO" >> /$DESTDIR2/$LOG
    fi
else
    echo -e "ESTE SCRITP NAO RODA NO SEU SISTEMA OPERACIONAL\nENTRE EM CONTATO COM O SUPORTE"
        echo
fi