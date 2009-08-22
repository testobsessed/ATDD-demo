import subprocess
import os.path


AUTHPATH = os.path.join(os.path.dirname(__file__), 
                        '..', '..', 'demo', 'src', 'auth.rb')


def create_user(username, password):
    return _run_command('create', username, password)

def attempt_to_login(username, password):
    return _run_command('login', username, password)


def _run_command(*args):
    cmd = ('ruby', AUTHPATH) + args
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    output = p.communicate()[0].strip()
    print output
    return output
    
