[[ "$0" == "./install.sh" ]] || { echo 'try ./install.sh' ; exit; }

echo export ZDOTDIR=$PWD >> ~/.zprofile
echo export ZDOTDIR=$PWD >> ~/.bashrc
