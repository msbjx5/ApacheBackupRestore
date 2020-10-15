#!/usr/bin/env bash

# verificando se o usuario e root
if [ "$EUID" -ne 0 ]; then
        echo "Desculpe, você precisa estar logado com usuário root"
		exit 1
fi
clear
echo "Este script irá desinstalar o sistema de backup do Apache2"
echo 
echo "Todos os backups e logs serão removidos"
echo
echo "Este procedimento é irreversível"
echo
echo "Prossiga somente se souber exatamente o que você está fazendo"
echo

read -p "Voce realmente deseja continuar (s/n)? " answer
case ${answer:0:1} in
    s|S )
        echo "Todos os arquivos estao sendo apagados"
        rm -rvf /bkp
        rm -rvf /var/log/CRON*
        rm -rvf /var/log/BACKUP*
        rm -rvf /var/log/RESTORE*
    echo
    echo
    echo
    echo "Todos os arquivos gerados pelo sistema de backup foram apagados"
    ;;
    * )
        echo
        echo "Voce cancelou a desinstalacao"
        echo
        echo "Nenhuma alteracao foi realizada"
        echo
    ;;
esac