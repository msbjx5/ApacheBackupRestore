Shell script para identificação de distro, Debian ou CentOS + backup do Apache2/HTTPD, diretório de log, www e geração de log dos backups.

Extras:
Agendamento no CRON automatizado pelo script instalador com geração de log.
Script para restore dos backups realizados com geração de log.
Script para desinstalação completa da solução.
Caso queira validar a solução de backup e restauração execute o script validador.sh após já ter realizado um backup. Ele irá apagar os diretórios
do Apache2/HTTPD para que voce possa realizar o restore e validar o funcionamento da solução.
Arquivos e suas funções:Arquivo Funçãoinstall.sh script de instalação da solução e de agendamento no cronWebServerBackup.sh script que irá gerar os backups do Apache2/HTTPDrestore.sh script que irá realizar o restore dos backupsuninstall.sh script para desinstalação completa da solução 
Validação da ferramenta:Arquivo Funçãoapaga-webserver.sh script para exclusão das pastas as quais foram feitas o backup.valida-restore.sh script que lista as pastas e arquivos restaurados do backup. 
Pré requisitos para instalação e funcionamento dos scripts: 
Sistema operacional Debian + Apache2 e acesso ao sistema com permissão root. ou Sistema operacional CentOS + HTTPD e acesso ao sistema
com permissão root. 
1 - Instruções de download e preparação da instalação: 
Primeiramente clone o repositório com o comando abaixo:
git clone https://github.com/msbjx5/LinuxClasses.git
Entre na pasta com os scripts
cd LinuxClasses/Nac2
Dê permissão de execução para os scripts da pasta com o comando abaixo:
chmod +x *.sh
2 - Agendamento no cron: 
O instalador irá criar automaticamente um agendamento no cron para que o backup seja executado diariamente as 23:00 horas.
Caso não tenha necessidade de alterar o horário do agendamento pule diretamente para o passo 3.
Caso seja necessário alterar esse agendamento edite as linhas 34 e 46 do arquivo install.sh conforme sua necessidade.
2.1 - Instruções cron: 
.---------------- minutos (0 - 59)
| .------------- horas (0 - 23)
| | .---------- dia do mês (1 - 31)
| | | .------- mês (1 - 12) ou jan,fev,mar,abr ...
| | | | .---- dia da semana (0 - 6) (Domingo=0 ou 7) ou dom,seg,ter,qua,qui,sex,sab
| | | | |
* * * * * usuário comando-a-ser-executado3 - Instalação automatizada do script de backup e do
agendamento do crontab 
Execute o script de instalação e agendamento com permissão de root
sudo ./install.sh
Pronto !
O script de backup já está instalado e agendado para rodar conforme a data e hora selecionada.
4 - Restauração dos backups 
Entre na pasta /bkp/script e execute o arquivo restore.sh com permissao de root digitando o comando abaixo:
cd /bkp/script
sudo ./restore.sh
Siga as instruções na tela
5 - Desinstalação do script de backup 
Entre na pasta /bkp/script e execute o arquivo uninstall.sh com permissão de root digitando o comando abaixo:
cd /bkp/script
sudo ./uninstall.sh
Todos os arquivos gerados pelo instalador bem como os backups e logs gerados serão apagados, esse procedimento é irreversível.
Observações 
Overview da estrutura de diretórios e locais onde serão salvos os arquivos gerados pelos scripts.
Diretorio Função/bkp Local de armazenamento dos backups./bkp/script Local de armazenamento dos scripts./var/log Local de armazenamento dos logs de backup, de restore e agendamento do cron. 
Overview da nomenclatura dos arquivos:
Arquivos de log do agendamento do script no CRON serão gerados conforme a nomenclatura abaixo:
CRONWebServerBackup-DDMMAA_HHMMSS.log
Arquivos de backup serão gerados conforme a nomenclatura abaixo:
BACKUPWebServer-DDMMAA_HHMMSS.log
Arquivos de restore do backup serão gerados conforme a nomenclatura abaixo:
RESTOREWebServerBackup–DDMMAA_HHMMSS.log