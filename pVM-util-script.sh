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
		deploy : build and install components of Phoenix-VM 
		
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
    sed -i /etc/apt/sources.list 
    apt-get update 
    apt-get build-dep xen
}

function _check_linux_dependencies()
{
    apt update 
    apt install texinfo
}

function _install_linux_dependencies()
{

}



#########################################
# install dependencies and purge data	#
#########################################
EXPECTED_ARGS=3
E_BADARGS=65


if [ $# -ne $EXPECTED_ARGS ]
then
    _error "Please pass a keyword [deploy | runtest] with the appropriate parameters.\n Help() : "
    _printHelp 
    exit E_BADARGS=65
fi

if [ $1 == "deploy" ] 
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
	fi

	_error "Bad input. Help(): "
	_printHelp
	exit E_BADARGS=65
	

fi

_bold "Checking dependencies presence"

_success "Successfully loaded the demo values"

_bold "Installing node packages ...."

npm install .

_bold "Serving the website ...."

_success "Test with the date 2018-05-31 00:00"

npm start .

_grafittiPrinter



