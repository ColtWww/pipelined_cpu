import os
import subprocess
import sys
import shutil
import filecmp
import subprocess
import sys
import os

def list_binfiles(path):
    files = []
    list_dir = os.walk(path)
    for maindir, subdir, all_file in list_dir:
        for filename in all_file:
            apath = os.path.join(maindir, filename)
            if apath.endswith('.bin'):
                files.append(apath)

    return files

def main():
    bin_files = list_binfiles(r'./example')

    anyfail = False


    for file in bin_files:
        #print(file)
        #cmd = r'python sim_new_nowave.py' + ' ' + file + ' ' + 'inst.data'

        cmd = r'python ./BinToMem_CLI.py' + ' ' + file + ' ' + './inst.data'
        f = os.popen(cmd)
        f.close()
        print("***", file)
        shutil.copy('./inst.data', './inst_data/{}.data'.format(file.split('.bin')[0].split('\\')[-1]))


if __name__ == '__main__':
    sys.exit(main())
