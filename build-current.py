from pathlib import Path
import os,subprocess
r=Path(os.environ['STACKOS_BUILD_ROOT']).resolve()
assert 'StackOS C3' in (r/'release-root/etc/os-release').read_text()
for name in ['package-candidate.py','seal.py']:assert (r/name).is_file()
subprocess.run(['python3',str(r/'package-candidate.py')],check=True)
subprocess.run(['sudo','-n','-H','-u','Not','python3',str(r/'sign-repo.py')],check=True)
subprocess.run(['python3',str(r/'seal.py')],check=True)
