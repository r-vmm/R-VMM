#Function Helpers 

_red=$(tput setaf 1)
_green=$(tput setaf 76)
_bold=$(tput bold)
_reset=$(tput sgr0)

function _success()
{
    printf "${_green}✔ %s${_reset}\n" "$@"
}

function _error() {
    printf "${_red}✖ %s${_reset}\n" "$@"
}

function _printHelp(){
     echo -n "$(basename $0) [TASK] [PARAM]

	TASK:
		install : build and install components of Phoenix-VM 
		
			- linux: deploy linux kernel
			- xen : deploy modified xen hypervisor
		
		runtest : Run benchmarks such as Tailbench or apache bench 

			- tailbench: run tailbench benchmarks 
			- ab : run apache bench benchmark	

    Examples:
        - $(basename $0) deploy linux
	- $(basename $0) deploy xen 
	- $(basename $0) runtest ab 

"
    exit 1
}

function _grafittiPrinter()
{
    cat <<"EOF"
__________.__                         .__                     ____   _________
\______   \  |__   ____   ____   ____ |__|__  ___ ______ _____\   \ /   /     \
 |     ___/  |  \ /  _ \_/ __ \ /    \|  \  \/  / \____ \\____ \   Y   /  \ /  \
 |    |   |   Y  (  <_> )  ___/|   |  \  |>    <  |  |_> >  |_> >     /    Y    \
 |____|   |___|  /\____/ \___  >___|  /__/__/\_ \ |   __/|   __/ \___/\____|__  /
               \/            \/     \/         \/ |__|   |__|                 \/
EOF
}

function _bold()
{
    printf "${_bold}%s${_reset}\n" "$@"
}

function _install_xen_dependencies()
{
    #Update /etc/apt/sources.list
    sudo sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
    sudo apt-get update 
    sudo apt-get build-dep xen
	sudo apt-get install build-essential
	sudo apt-get install bcc bin86 gawk bridge-utils iproute libcurl3 libcurl4-openssl-dev bzip2 module-init-tools transfig tgif 
	sudo apt-get install texinfo texlive-latex-base texlive-latex-recommended texlive-fonts-extra texlive-fonts-recommended pciutils-dev mercurial
	sudo apt-get install make gcc libc6-dev zlib1g-dev python python-dev python-twisted libncurses5-dev patch libvncserver-dev libsdl-dev libjpeg62-dev
	sudo apt-get install iasl libbz2-dev e2fslibs-dev git-core uuid-dev ocaml ocaml-findlib libx11-dev bison flex xz-utils libyajl-dev
	sudo apt-get install gettext libpixman-1-dev libaio-dev markdown pandoc
	sudo apt-get install libc6-dev-i386

	sudo apt-get install checkpolicy #For XSM handling 

	_bold "Xen dependencies installed successfully. Moving on to Xen build".

	_install_xen 
}

function _abort()
{
	_error "Something went wrong, please check output messages to find the whereabouts."
}

function _install_xen()
{
	_bold "Starting Xen hypervisor build ..."
	cd ./xen-res/
	./configure 
	make clean 
	make -C tools/flask/policy 2> /dev/null && echo "" || echo _abort
	make -j$(nproc)
	if [ $? -ne 0 ]
	then 
		sudo make install 
		sudo ldconfig 

		_bold "Xen successfully build and installed."
		
		_grafittiPrinter
		_success "Reboot the server and run `/etc/init.d/xencommons start` to launch the hypervisor."
		
	else 
		_abort 
	fi 
	
}

function _check_linux_dependencies()
{
    apt update 
    apt install texinfo
}

function _install_linux_dependencies()
{
	
	apt-get install build-essential libncurses-dev bison flex libssl-dev libelf-dev
	_bold "Installing linux dependencies"
	
	cd ./linux-res/
	
	_bold "Building linux 5.0.8"
	cp -v /boot/config-$(uname -r) .config
	make -j$(nproc)
	if [ $? -ne 0 ]
	then

		sudo make modules_install -j$(nproc)
		sudo make install -j$(nproc)
		sudo update-grub

		_grafittiPrinter
		_success "Linux Build successful. Reboot choosing linux-5.0.8 kernel then run $(basename) $0 install xen to build xen."
	else 
		_abort 
	fi 

}



#########################################
# install dependencies and purge data	#
#########################################
EXPECTED_ARGS=2
E_BADARGS=65


if [ $# -ne $EXPECTED_ARGS ]
then
    _error "Please pass a keyword [install | runtest] with the appropriate parameters.\n Help() : "
    _printHelp 
    exit E_BADARGS=65
fi

if [ $1 == "install" ] 
then 
	if [ $2 == "linux" ]
	then 
		#Install our linux version
		#first check dependencies 
		
		_check_linux_dependencies

		_install_linux_dependencies

	fi

	if [ $2 == "xen" ]
	then 
		_install_xen_dependencies
		_install_xen
	fi

	_error "Bad input, option $2 not recognized. Please take a look at the help(): "
	_printHelp
	exit E_BADARGS=65
	

fi

#@TODO : Runtest for tailbench and apache 

if [ $1 == "runtest" ]
then 
	_bold "Test scripts coming soon. Stay Tuned !!!"
fi




