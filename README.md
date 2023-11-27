# script_instalacao
Script de instalação docker, imagem ubuntu e API GCT

Para subir um ambiente, insira o comando:
docker build -t env_script_instalacao .

Crie uma instância com o comando:
docker run -d -t --name esi env_script_instalacao

E interaja com o seu novo container através do bash com o seguinte comando:
docker exec -it esi bash

Não esqueça de parar o container quando terminar de usar, e se precisar voltar é só o ligar novamente.


