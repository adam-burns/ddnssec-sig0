PROJECT := ddnssec-bind

init:
	# export ANSIBLE_ROLES_PATH="/etc/ansible/roles:./roles"
	ansible-galaxy install systemli.bind9
	sed -i -e 's/name: bind9/name: named/g' ~/.ansible/roles/systemli.bind9/handlers/main.yml
	#sudo mkdir -p /etc/bind/zones && sudo chown bind /etc/bind/zones
	#sudo mkdir -p /etc/bind/keys && sudo chown bind /etc/bind/keys

deploy:
	export ANSIBLE_ROLES_PATH="/etc/ansible/roles:./roles"
	ansible-playbook -i hosts.yml main.yml

clean-all:
	sudo apt purge bind9 -y
	sudo rm -fr /etc/bind/zones/*
	sudo rm -fr /etc/bind/keys/*
	sudo rm -fr /var/cache/bind
	rm -fr roles
	rm -fr ~/.ansible
