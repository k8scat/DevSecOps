import sys
import time
from datetime import datetime
import ssl
import socket


def get_ssl_info(domain, port=443):
    server_name = domain
    sslinfo = {}

    context = ssl.SSLContext(ssl.PROTOCOL_TLS_CLIENT)
    context.verify_mode = ssl.CERT_REQUIRED
    context.check_hostname = True
    context.load_default_certs()

    s = socket.socket()
    s = context.wrap_socket(s, server_hostname=server_name)
    s.connect((server_name, port))
    s.do_handshake()
    cert = s.getpeercert()

    e_time = ssl.cert_time_to_seconds(cert['notAfter'])
    remain_days = e_time - time.time()
    remain_days = round(remain_days/86400)
    e_time = datetime.utcfromtimestamp(e_time)

    s_time = ssl.cert_time_to_seconds(cert['notBefore'])
    s_time = datetime.utcfromtimestamp(s_time)

    check_time = datetime.utcnow()

    sslinfo['check_time'] = str(check_time)
    sslinfo['domain'] = server_name
    sslinfo['s_time'] = str(s_time)
    sslinfo['e_time'] = str(e_time)
    sslinfo['remain_days'] = remain_days

    return sslinfo


if __name__ == '__main__':
    if len(sys.argv) == 1:
        print(f'usage: {sys.argv[0]} <domain> [port=443]')
        sys.exit(1)
    if len(sys.argv) == 2:
        domain = sys.argv[1]
    elif len(sys.argv) >= 3:
        domain = sys.argv[2]
        port = int(sys.argv[3])
        
    print(get_ssl_info(domain, port))
