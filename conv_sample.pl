#!/usr/local/bin/perl

$src = "./source";						# 入力元フォルダ
$dst = "./out";							# 出力先フォルダ

# 処理対象ファイル拡張子（正規表現）
$ext = "(c|h|ASM|m|p|t|_t|_r|f06|g06|inc)";

# 変換処理開始
&search_dir( $src, $dst );
exit();

##### Subroutine #####
# ファイル処理サブルーチン
sub proc_file {

	my($i_path, $o_path) = @_;

	print "$i_path\n";

	open(IN, $i_path) or die $!;
	open(OUT, "> $o_path") or die $!;

	while (<IN>) {
		
		
		
		
		
		
		
		
		
		print OUT $_;
	}
	close(IN);
	close(OUT);
}




# フォルダサーチサブルーチン
sub search_dir {

	my($i_path, $o_path) = @_;
	my(@f_list, $f_name, $i_file, $o_file);

	# ファイル名取得
	opendir(INDIR, $i_path) or die $!;
	@f_list = readdir(INDIR);
	closedir(INDIR);

	# 出力先フォルダ作成
	if (!opendir( OUTDIR, $o_path )) {
		mkdir( $o_path, 0777 ) or die $!;
	}
	closedir( OUTDIR );

	# 各ファイル/フォルダの処理
	foreach $f_name ( sort( @f_list ) ){
		
		# カレントフォルダまたは親フォルダは除外する
		if ($f_name ne '.' && $f_name ne '..'){
			$i_file = $i_path . "/" . $f_name;
			$o_file = $o_path . "/" . $f_name;

			if (-d $i_file) {
				# フォルダなら再帰呼び出し
				&search_dir( $i_file, $o_file );
			}
			elsif (-f $i_file && $i_file =~ /\.$ext$/) {
				# 処理対象の拡張子のファイルのみ処理
				&proc_file( $i_file, $o_file );
			}
		}
	}
}

