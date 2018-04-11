@echo off

REM ## markdown �`���̃t�@�C�����X�g���쐬����B
if exist mdlist.txt del mdlist.txt
for %%a in (source\*.md) do (
  echo %%a >> mdlist.txt
)

REM ## markdown �`���̃t�@�C���� reStructuredText �`����
REM ## �ϊ�����R�}���h�𗅗񂷂�B
echo @echo off > __md2rst.bat
for /f "tokens=1,2 delims=." %%a in (mdlist.txt) do (
  echo pandoc -f markdown -t rst -o %%a.rst %%a.%%b >> __md2rst.bat
)

REM ## md ���� rst �ɕϊ�����B
call __md2rst.bat
del __md2rst.bat mdlist.txt

REM ## ���ł� HTML ����������B
make html
