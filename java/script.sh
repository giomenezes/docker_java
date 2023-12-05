#!/bin/bash

# Config.
versao_recomendada_java="17.0.6"

echo " ██████╗ ██████╗ ███████╗██╗   ██╗"
echo "██╔════╝ ██╔══██╗██╔════╝╚██╗ ██╔╝"
echo "██║  ██╗ ██████╔╝█████╗   ╚████╔╝"
echo "██║  ╚██╗██╔══██╗██╔══╝    ╚██╔╝"
echo "╚██████╔╝██║  ██║███████╗   ██║"
echo " ╚═════╝ ╚═╝  ╚═╝╚══════╝   ╚═╝"
echo ""
echo " █████╗ ██╗      █████╗ ██╗   ██╗██████╗"
echo "██╔══██╗██║     ██╔══██╗██║   ██║██╔══██╗"
echo "██║  ╚═╝██║     ██║  ██║██║   ██║██║  ██║"
echo "██║  ██╗██║     ██║  ██║██║   ██║██║  ██║"
echo "╚█████╔╝███████╗╚█████╔╝╚██████╔╝██████╔╝"
echo " ╚════╝ ╚══════╝ ╚════╝  ╚═════╝ ╚═════╝"
echo ""
echo "████████╗██████╗  █████╗ ███╗  ██╗ ██████╗ █████╗  █████╗ ████████╗██╗ █████╗ ███╗  ██╗ ██████╗"
echo "╚══██╔══╝██╔══██╗██╔══██╗████╗ ██║██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██║██╔══██╗████╗ ██║██╔════╝"
echo "   ██║   ██████╔╝███████║██╔██╗██║╚█████╗ ███████║██║  ╚═╝   ██║   ██║██║  ██║██╔██╗██║╚█████╗ "
echo "   ██║   ██╔══██╗██╔══██║██║╚████║ ╚═══██╗██╔══██║██║  ██╗   ██║   ██║██║  ██║██║╚████║ ╚═══██╗"
echo "   ██║   ██║  ██║██║  ██║██║ ╚███║██████╔╝██║  ██║╚█████╔╝   ██║   ██║╚█████╔╝██║ ╚███║██████╔╝"
echo "   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚══╝╚═════╝ ╚═╝  ╚═╝ ╚════╝    ╚═╝   ╚═╝ ╚════╝ ╚═╝  ╚══╝╚═════╝ "

linha="=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"

echo $linha
echo "                             [@] SCRIPT DE INSTALAÇÃO"
echo "                             [@] Equipe GCT - 1° CCO "
echo $linha

echo ""

echo "[!] Fazendo verificação do Java"
which java | grep /usr/bin/java

if [ $? = 0 ]; then
	versao_java=$(java -version 2>&1 | awk -F'"' '{print $2}')
        echo "[!] Versão do Java Instalada: $versao_java"
        
        if [ "$versao_java" = $versao_recomendada_java ]; then 
		echo "[!] Esta versão está de acordo com a API da GCT."
		echo "[!] Finalizando o Script."
            else    
                echo "[ALERT] Esta versão NÃO é adequada para a API da GCT."
                echo "[?] Deseja atualizar para a versão recomendada? [s/n]"
                
                read escolha
                
                if [ $escolha = "s" ]; then
		        apt-get install openjdk-17-jre -y
		        echo "[!] O Java foi atualizado com sucesso."
		        echo "[!] Finalizando o script"
                    else
                        echo "[!] Finalizando o script de instalação!"
		fi
		fi
	else
		echo ""
		echo "[ALERT] O Java não está instalado"
		echo "[?] Deseja Instalar o Java? [s/n]"
		
		read get
		
		if [ $get = "s" ]; then
			apt-get install openjdk-17-jre -y
			echo "[!] O Java foi  Instalado!"
		else
			echo "Cancelando instalação"
		fi
fi

echo "Instalando API GCT"
	apt install wget
	wget https://github.com/giomenezes/monitoramento-processos/releases/download/1.0.5/monitoramento-processos-1.0.5.jar
	echo "API GCT instalada com sucesso!"

echo "Inicializando API"
java -jar CLI-GCT-1.0-SNAPSHOT.jar

