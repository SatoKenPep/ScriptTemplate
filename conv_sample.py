#!/usr/local/bin/python
# -*- coding: s-jis -*-

import sys
import os
import re

src = "source"						# 入力元フォルダ
dst = "out"							# 出力先フォルダ

# 処理対象ファイル拡張子（正規表現）
ext = "\\.(c|h|ASM|m|p|t|_t|_r|f06|g06|inc)$"

##### Subroutine #####
# ファイル処理サブルーチン
def proc_file(i_path, o_path):
	
	print("proc_file: ", i_path, ",", o_path)
	
	f_i = open(i_path, "r")
	f_o = open(o_path, "w")
	
	for row in f_i:
		f_o.write(row)
	
	f_i.close()
	f_o.close()


# プログラムメイン
if __name__ == "__main__":
	
	# 出力先フォルダが存在しない場合、フォルダ作成
	if os.path.exists(dst) != True:
		os.mkdir(dst)
	
	# 入力元フォルダ内の検索、各ファイル/フォルダの処理
	for d_path, d_names, f_names in os.walk(src):
		
		print( "d_path: ", d_path )
		print( "d_names:", d_names)
		print( "f_names:", f_names)
		
		# ファイル毎の処理
		for f_name in f_names:
			
			i_file = os.path.join(d_path, f_name)
			o_file = i_file.replace(src, dst)
			
			# 処理対象の拡張子のファイルのみ処理
			if re.search(ext, i_file):
				proc_file( i_file, o_file )
		
		# サブフォルダ毎の処理
		for d_name in d_names:
			
			# 出力先サブフォルダ名の生成
			i_file = os.path.join(d_path, d_name)
			o_file = i_file.replace(src, dst)
			
			# 出力先サブフォルダが存在しない場合、フォルダ作成
			if os.path.exists(o_file) != True:
				os.mkdir(o_file)
	
	# 全ての処理終了
	sys.exit()

