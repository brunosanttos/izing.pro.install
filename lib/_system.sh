#!/bin/bash
# 
# system management

#######################################
# creates user
# Arguments:
#   None
#######################################
system_create_user() {
  print_banner
  printf "${WHITE} 💻 Agora, vamos criar o usuário para deploy...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  useradd -m -p $(openssl passwd $deploy_password) -s /bin/bash -G sudo deploy
  usermod -aG sudo deploy
EOF

  sleep 2
}


instalacao_firewall() {
  print_banner
  printf "${WHITE} 💻 Agora, vamos instalar e ativar firewall UFW...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
apt install -y ufw
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 22
ufw allow 80
ufw allow 443
ufw allow 9000
ufw --force enable
echo "{\"iptables\": false}" > /etc/docker/daemon.json
systemctl restart docker
sed -i -e 's/DEFAULT_FORWARD_POLICY="DROP"/DEFAULT_FORWARD_POLICY="ACCEPT"/g' /etc/default/ufw
ufw reload
wget -O /usr/local/bin/ufw-docker https://github.com/chaifeng/ufw-docker/raw/master/ufw-docker
chmod +x /usr/local/bin/ufw-docker
ufw-docker install
systemctl restart ufw

EOF

  sleep 2
}

iniciar_firewall() {
  print_banner
  printf "${WHITE} 💻 Iniciando Firewall...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  service ufw start
  
EOF

  sleep 2
}

parar_firewall() {
  print_banner
  printf "${WHITE} 💻 Parando Firewall(atenção seu servidor ficara desprotegido)...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  service ufw stop
  
EOF

  sleep 2
}

#######################################
# set timezone
# Arguments:
#   None
#######################################
system_set_timezone() {
  print_banner
  printf "${WHITE} 💻 Setando timezone...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  timedatectl set-timezone America/Sao_Paulo
EOF

  sleep 2
}

#######################################
# unzip izing
# Arguments:
#   None
#######################################
system_unzip_izing() {
  print_banner
  printf "${WHITE} 💻 Fazendo unzip izing...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  cd /home/deploy/  
  wget --user ${username_down} --password ${senha_down} https://infomeurer.com.br/restrito/izing.zip
  unzip izing.zip
  chmod 775 izing.io/ -Rf
  rm izing.zip
EOF

  sleep 2
}

verificar_senha() {
  print_banner
  printf "${WHITE} 💻 Verificando usuario e senha...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  rm teste.txt
  wget --user ${username_down} --password ${senha_down} https://infomeurer.com.br/restrito/teste.txt
  
if [ ! -f teste.txt ]; then
    echo -e "\033[1;31mSerá que sua senha está correta? Pode estar vencida?\033[0m"
	echo -e "\033[1;31mAperte Ctrl + c para sair\033[0m"
sleep 99999999
fi

EOF

  sleep 2
}


#######################################
# update izing
# Arguments:
#   None
#######################################
system_update_izing() {
  print_banner
  printf "${WHITE} 💻 Fazendo unzip izing atualizado...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  cd /home/deploy/
  wget --user ${username_down} --password ${senha_down} https://infomeurer.com.br/restrito/update.zip
  unzip -o update.zip
  sleep 2
  chmod 775 izing.io/ -Rf
  rm update.zip
EOF

  sleep 2
}

#######################################
# updates system
# Arguments:
#   None
#######################################
system_update() {
  print_banner
  printf "${WHITE} 💻 Vamos atualizar o sistema...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  apt -y update && apt -y upgrade
  apt autoremove -y
  sudo ufw allow 443/tcp
  sudo ufw allow 80/tcp
EOF

  sleep 2
}

#######################################
# installs node
# Arguments:
#   None
#######################################
system_node_install() {
  print_banner
  printf "${WHITE} 💻 Instalando nodejs...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
  apt-get install -y nodejs
EOF

  sleep 2
}

#######################################
# installs docker
# Arguments:
#   None
#######################################
system_docker_install() {
  print_banner
  printf "${WHITE} 💻 Instalando docker...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
  apt install -y docker-ce
EOF

  sleep 2
}

#######################################
# Ask for file location containing
# multiple URL for streaming.
# Globals:
#   WHITE
#   GRAY_LIGHT
#   BATCH_DIR
#   PROJECT_ROOT
# Arguments:
#   None
#######################################
system_puppeteer_dependencies() {
  print_banner
  printf "${WHITE} 💻 Instalando puppeteer dependencies...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
apt install -y apt-transport-https ca-certificates software-properties-common curl libgbm-dev wget unzip fontconfig locales gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils python2-minimal build-essential libxshmfence-dev nginx
EOF

  sleep 2
}

system_pm2_stop() {
  print_banner
  printf "${WHITE} 💻 Parando o izing...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  pm2 stop all
EOF

  sleep 2
}

system_pm2_start() {
  print_banner
  printf "${WHITE} 💻 Iniciando o izing...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  pm2 start all
EOF

  sleep 2
}


#######################################
# installs pm2
# Arguments:
#   None
#######################################
system_pm2_install() {
  print_banner
  printf "${WHITE} 💻 Instalando pm2...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  npm install -g pm2
  pm2 startup ubuntu -u deploy
  env PATH=\$PATH:/usr/bin pm2 startup ubuntu -u deploy --hp /home/deploy
EOF

  sleep 2
}

#######################################
# installs snapd
# Arguments:
#   None
#######################################
system_snapd_install() {
  print_banner
  printf "${WHITE} 💻 Instalando snapd...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  apt install -y snapd
  snap install core
  snap refresh core
EOF

  sleep 2
}

#######################################
# installs certbot
# Arguments:
#   None
#######################################
system_certbot_install() {
  print_banner
  printf "${WHITE} 💻 Instalando certbot...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  apt-get remove certbot
  snap install --classic certbot
  ln -s /snap/bin/certbot /usr/bin/certbot
EOF

  sleep 2
}

#######################################
# installs nginx
# Arguments:
#   None
#######################################
system_nginx_install() {
  print_banner
  printf "${WHITE} 💻 Instalando nginx...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  rm /etc/nginx/sites-enabled/default
EOF

  sleep 2
}

#######################################
# install_chrome
# Arguments:
#   None
#######################################
system_set_user_mod() {
  print_banner
  printf "${WHITE} 💻 Vamos atualizar o sistema...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  sudo usermod -aG docker deploy
  su - deploy
EOF

  sleep 2
}

#######################################
# restarts nginx
# Arguments:
#   None
#######################################
system_nginx_restart() {
  print_banner
  printf "${WHITE} 💻 reiniciando nginx...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  service nginx restart
EOF

  sleep 2
}

#######################################
# setup for nginx.conf
# Arguments:
#   None
#######################################
system_nginx_conf() {
  print_banner
  printf "${WHITE} 💻 configurando nginx...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

sudo su - root << EOF

cat > /etc/nginx/conf.d/izingio.conf << 'END'
client_max_body_size 20M;
END

EOF

  sleep 2
}

#######################################
# installs nginx
# Arguments:
#   None
#######################################
system_certbot_setup() {
  print_banner
  printf "${WHITE} 💻 Configurando certbot...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  backend_domain=$(echo "${backend_url/https:\/\/}")
  frontend_domain=$(echo "${frontend_url/https:\/\/}")
  admin_domain=$(echo "${admin_url/https:\/\/}")

  sudo su - root <<EOF
  certbot -m $deploy_email \
          --nginx \
          --agree-tos \
          --non-interactive \
          --domains $backend_domain,$frontend_domain
EOF

  sleep 2
}

#######################################
# reboot
# Arguments:
#   None
#######################################
system_reboot() {
  print_banner
  printf "${WHITE} 💻 Reboot...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  reboot
EOF

  sleep 2
}

#######################################
# creates docker db
# Arguments:
#   None
#######################################
system_docker_start() {
  print_banner
  printf "${WHITE} 💻 Iniciando container docker...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  docker stop $(docker ps -q)
  docker container start postgresql
  docker container start redis-izing
  docker container start rabbitmq
EOF

  sleep 2
}

#######################################
# creates docker db
# Arguments:
#   None
#######################################
system_docker_restart() {
  print_banner
  printf "${WHITE} 💻 Iniciando container docker...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  docker container restart portainer
  docker container restart postgresql
  docker container restart redis-izing
  docker container restart rabbitmq
EOF

  sleep 10
}



#######################################
# creates final message
# Arguments:
#   None
#######################################
system_success() {
  print_banner
  printf "${GREEN} 💻 Instalação concluída com Sucesso...${NC}"
  printf "${CYAN_LIGHT}";
  printf "\n\n"
  printf "Usuário: admin@izing.io"
  printf "\n"
  printf "Senha: 123456"
  printf "\n"
  printf "Usuário tenent: superadmin@izing.io"
  printf "\n"
  printf "Senha: 123456"
  printf "\n"
  printf "URL front: https://$frontend_domain"
  printf "\n"
  printf "URL back: https://$backend_domain"
  printf "\n"
  printf "Acesso ao Portainer: http://$frontend_domain:9000"
  printf "\n"
  printf "Senha Usuario deploy: $deploy_password"
  printf "\n"
  printf "Usuario do Banco de Dados: izing"
  printf "\n"
  printf "Nome do Banco de Dados: postgres"
  printf "\n"
  printf "Senha do Banco de Dados: $pg_pass"
  printf "\n"
  printf "Senha do Redis: $redis_pass"
  printf "\n"
  printf "Senha do Rabbit: $rabbit_pass"
  printf "\n"
  printf "${NC}";

  sleep 2
}

system_success2() {
  print_banner
  printf "${GREEN} 💻 Proscesso concluido acessar com aba anonima e verificar se numero versão alterou...${NC}"
  printf "${GREEN} Caso não tenha alterado veja motivos abaixo:${NC}"
  printf "${GREEN} Não tenha atualização...${NC}"
  printf "${GREEN} Sua senha para atualizar esta vencida...${NC}"
  printf "${GREEN} Você digitou usuario ou senha errado${NC}"
  printf "${GREEN} Se tiver duvidas chame no whatsapp${NC}"
  printf "${NC}";

  sleep 2
}
