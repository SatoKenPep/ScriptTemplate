Option Explicit
'------------------------------------------------------
' 
'------------------------------------------------------
' Source / Detination folder
Const src = "source"	' 入力元フォルダ
Const dst = "out"		' 出力先フォルダ

' 処理対象ファイル拡張子（正規表現）
Const ext = "(c|h|ASM|m|p|t|_t|_r|f06|g06|inc)"

'------------------------------------------------------
' 
'------------------------------------------------------
Dim objShell
Dim objFSO
Dim objRE
Dim src_path
Dim dst_path

Set objFSO = WScript.CreateObject("Scripting.FileSystemObject")
Set objRE  = new regexp

Set objShell = WScript.CreateObject("WScript.Shell")
src_path = objShell.CurrentDirectory + "\" + src
dst_path = objShell.CurrentDirectory + "\" + dst

Call search_dir( src_path, dst_path )

Set objRE = Nothing
Set objFSO = Nothing
Set objShell = Nothing

'------------------------------------------------------
' Procedure:処理対象ファイルを読み出し、変換処理を行う
' Input:	i_path		入力元フォルダ
'			o_path		出力先フォルダ
'			filename	処理対象ファイル名
'------------------------------------------------------
Sub proc_file( ByVal i_file, ByVal o_file )

	Dim objIStrm
	Dim objOStrm
	Dim text_line

	Set objIStrm = objFSO.OpenTextFile( i_file, 1 )
	Set objOStrm = objFSO.CreateTextFile( o_file, True )

	Do While objIStrm.AtEndOfStream <> True

		text_line = objIStrm.ReadLine
		objOStrm.WriteLine( text_line )

	Loop

	objOStrm.Close
	objIStrm.Close

	Set objOStrm = Nothing
	Set objIStrm = Nothing

End Sub
'------------------------------------------------------
' Procedure:入力元フォルダの処理対象ファイルを検索する
' Input:	i_path		入力元フォルダ
'			o_path		出力先フォルダ
'------------------------------------------------------
Sub search_dir( ByVal i_path, ByVal o_path )

	Dim objFolder
	Dim objFile
	Dim objSub
	Dim new_i_path, new_o_path

	If objFSO.FolderExists( o_path ) = False Then
		objFSO.CreateFolder( o_path )
	End If

	Set objFolder = objFSO.GetFolder( i_path )
	For Each objFile in objFolder.Files
		new_i_path = i_path + "\" + objFile.Name
		new_o_path = o_path + "\" + objFile.Name
		
		objRE.Pattern = "\\." + ext + "$"
		If objRE.Test( objFile.Name ) = True Then
			Call proc_file( new_i_path, new_o_path )
		End If
	Next
	For Each objSub in objFolder.SubFolders
		new_i_path = i_path + "\" + objSub.Name
		new_o_path = o_path + "\" + objSub.Name
		
		Call search_dir( new_i_path, new_o_path )
	Next

	Set objFolder = Nothing
	Set objFile = Nothing
	Set objSub = Nothing

End Sub
