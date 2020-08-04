export NEST=0
_up      () {  export NEST=$((${NEST}+1)); }
_down    () {  export NEST=$((${NEST}-1)); }
_tab     () { [[ "${NEST}" == "0" ]] || for i in $( seq ${NEST} ); do printf '\\t'; done ; }
_color   () { tput setaf $1; [[ "$2" == "." ]] || tput setab $2; shift; shift; echo -n $*; tput sgr0; }
_black   () { _color 15  0 $(_tab)$*; echo; }
_blue    () { _color 15  4 $(_tab)$*; echo; }
_yellow  () { _color 16 11 $(_tab)$*; echo; }
_green   () { _color  0 10 $(_tab)$*; echo; }
_red     () { _color 15  9 $(_tab)$*; echo; }

function --doc {
    true;
}

function .note { --doc Log a note
    _green "# $*"
}

function .exec { --doc Log an execution
    _red exec: $*
    $*
}

function .dump { --doc Dump the log file
    cat ${LOG}
}

function .log { --doc Append a line to the lof file
    echo $* >> ${LOG}
}


function .export { --doc Log an export
    _blue "setting \$$1 := [$2]"
    export $1=$2
}

function .source { --doc Log a source with nesting
    _yellow "++[. $*]" ;
    _up ;
    [[ -f ${SPLASH} ]] || echo source $*
    source $* ;
    _down ;
    _yellow "--[. $*]"
}

function .help { --doc Display documented functions
    grep * -e "--doc"  | grep --color=always -e " \..*"
}

