#!/usr/bin/env python2
import os, sys, socket, re, time

#os.chdir(os.path.dirname(__file__))
os.chdir(os.path.dirname(sys._getframe().f_code.co_filename))
try:
    username = open('key/user').read().strip()
    password = open('key/pass').read().encode('hex').upper()
except:
    print 'read key/user or key/pass error, run ./gen_pass.sh'
    sys.exit()

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect(('bnac.baidu.com', 10001))
sock.send('AUTH\r\nUSER:%s\r\nPASS:%s\r\nAUTH_TYPE:DOMAIN\r\n\r\n' % (username, password))
buf = sock.recv(1024)
if buf.startswith('200'):
    buf = sock.recv(1024)
mo_role = re.search('ROLE:(\d+)', buf)
mo_session_id = re.search('SESSION_ID:(\d+)', buf)
if not (buf.startswith('288') and mo_role and mo_session_id):
    sock.close()
    print 'error getting role and session_id'
    sys.exit()
role = int(mo_role.group(1))
session_id = int(mo_session_id.group(1))
sock.send('PUSH\r\nROLE:%d\r\nTIME:%s\r\nSESSIONID:%d\r\n\r\n' % (role, '0' * 32, session_id))
buf = sock.recv(1024)
sock.close()
if not buf.startswith('220'):
    print 'push error\n'
    sys.exit()
print 'Passed Zhunru!'
while True:
    time.sleep(60)
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.connect(('bnac.baidu.com', 10001))
    sock.send('KEEP_ALIVE\r\nSESSIONID:%d\r\nUSER:%s\r\nAUTH_TYPE:DOMAIN\r\n\r\n' % (session_id, username))
    sys.stdout.write('.')
    sys.stdout.flush()
