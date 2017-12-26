import json
import sys

from medallion import (application_instance, get_config, init_backend,
                       set_config)


def main():

    if len(sys.argv) < 2:
        raise ValueError("No config file")
    config_file_path = sys.argv[1]
    with open(config_file_path, 'r') as f:
        set_config(json.load(f))

    init_backend(get_config()['backend'])

    IP = '0.0.0.0'
    PORT = 9999
    if len(sys.argv) < 3:
        print "No port, use 9999 as default"
    else:
        PORT = int(sys.argv[2])
    application_instance.run(debug=True, host=IP, port=PORT)


if __name__ == '__main__':
    main()
