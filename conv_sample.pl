#!/usr/local/bin/perl

$src = "./source";						# ���͌��t�H���_
$dst = "./out";							# �o�͐�t�H���_

# �����Ώۃt�@�C���g���q�i���K�\���j
$ext = "(c|h|ASM|m|p|t|_t|_r|f06|g06|inc)";

# �ϊ������J�n
&search_dir( $src, $dst );
exit();

##### Subroutine #####
# �t�@�C�������T�u���[�`��
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




# �t�H���_�T�[�`�T�u���[�`��
sub search_dir {

	my($i_path, $o_path) = @_;
	my(@f_list, $f_name, $i_file, $o_file);

	# �t�@�C�����擾
	opendir(INDIR, $i_path) or die $!;
	@f_list = readdir(INDIR);
	closedir(INDIR);

	# �o�͐�t�H���_�쐬
	if (!opendir( OUTDIR, $o_path )) {
		mkdir( $o_path, 0777 ) or die $!;
	}
	closedir( OUTDIR );

	# �e�t�@�C��/�t�H���_�̏���
	foreach $f_name ( sort( @f_list ) ){
		
		# �J�����g�t�H���_�܂��͐e�t�H���_�͏��O����
		if ($f_name ne '.' && $f_name ne '..'){
			$i_file = $i_path . "/" . $f_name;
			$o_file = $o_path . "/" . $f_name;

			if (-d $i_file) {
				# �t�H���_�Ȃ�ċA�Ăяo��
				&search_dir( $i_file, $o_file );
			}
			elsif (-f $i_file && $i_file =~ /\.$ext$/) {
				# �����Ώۂ̊g���q�̃t�@�C���̂ݏ���
				&proc_file( $i_file, $o_file );
			}
		}
	}
}

