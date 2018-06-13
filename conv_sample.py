#!/usr/local/bin/python
# -*- coding: s-jis -*-

import sys
import os
import re

src = "source"						# ���͌��t�H���_
dst = "out"							# �o�͐�t�H���_

# �����Ώۃt�@�C���g���q�i���K�\���j
ext = "\\.(c|h|ASM|m|p|t|_t|_r|f06|g06|inc)$"

##### Subroutine #####
# �t�@�C�������T�u���[�`��
def proc_file(i_path, o_path):
	
	print("proc_file: ", i_path, ",", o_path)
	
	f_i = open(i_path, "r")
	f_o = open(o_path, "w")
	
	for row in f_i:
		f_o.write(row)
	
	f_i.close()
	f_o.close()


# �v���O�������C��
if __name__ == "__main__":
	
	# �o�͐�t�H���_�����݂��Ȃ��ꍇ�A�t�H���_�쐬
	if os.path.exists(dst) != True:
		os.mkdir(dst)
	
	# ���͌��t�H���_���̌����A�e�t�@�C��/�t�H���_�̏���
	for d_path, d_names, f_names in os.walk(src):
		
		print( "d_path: ", d_path )
		print( "d_names:", d_names)
		print( "f_names:", f_names)
		
		# �t�@�C�����̏���
		for f_name in f_names:
			
			i_file = os.path.join(d_path, f_name)
			o_file = i_file.replace(src, dst)
			
			# �����Ώۂ̊g���q�̃t�@�C���̂ݏ���
			if re.search(ext, i_file):
				proc_file( i_file, o_file )
		
		# �T�u�t�H���_���̏���
		for d_name in d_names:
			
			# �o�͐�T�u�t�H���_���̐���
			i_file = os.path.join(d_path, d_name)
			o_file = i_file.replace(src, dst)
			
			# �o�͐�T�u�t�H���_�����݂��Ȃ��ꍇ�A�t�H���_�쐬
			if os.path.exists(o_file) != True:
				os.mkdir(o_file)
	
	# �S�Ă̏����I��
	sys.exit()

