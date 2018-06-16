if [ "${1:0:1}" != '-' ]; then
    exec "$@"
fi
