#!/bin/bash

function report_status
{
    if [[ $1 == 0 ]]; then
		echo -e "\033[092mSUCCESS\033[0m";
	else
		echo -e "\033[091mFAILED\033[0m";
	fi
	return 0;
}

aa
uid=$(uid -u)
if [ "$uid" != "0" ]; then
	echo "You need administrative privileges to run this script."
	exit
fi

REPO_LINK=https://github.com/JPaulMora/Pyrit
MAIN_FOLDER=/opt/Pyrit
OPENCL_FOLDER=${MAIN_FOLDER}/modules/cpyrit_opencl

cd /opt
echo -n "[+] Cloning repository from remote: "
git clone ${REPO_LINK} > /dev/null 2>&1


echo "[+] Installing dependencies ... "
apt-get install python-dev opencl-headers libssl-dev ocl-icd-opencl-dev libpcap-dev -y > /dev/null 2>&1

echo "[+] Compiling OpenCL module ... "
cd ${OPENCL_FOLDER}
python setup.py install > /dev/null 2>&1

echo "[+] Compiling main module (pyrit) ... "
cd ${MAIN_FOLDER}
python setup.py install > /dev/null 2>&1

echo "[*] Installation complete. "
echo "Do not forget to change OPEN_CL flag to True in ~/.pyrit/config file"
exit


