extends Node

"""
Easy Save-简单保存
作者:bilipeaches
版本:1.0
"""

# 检测文件夹
func has_folder(path):
	var dir = Directory.new()
	if dir.dir_exists(path):
		return true
	else:
		return false

# 检测文件
func has_file(path):
	var f = File.new()
	if f.file_exists(path):
		f.close()
		return true
	else:
		f.close()
		return false

# 读取函数(不加密)
func load_data(path):
	var loader = File.new()
	loader.open(path, File.READ)
	# 读取json
	var json = parse_json(loader.get_as_text())
	# 关闭
	loader.close()
	return json

# 保存函数(不加密)
func save_data(path, game_data):
	var saver = File.new()
	saver.open(path, File.WRITE)
	# 写入
	saver.store_line(to_json(game_data))
	# 关闭
	saver.close()
	return true

# 读取函数(自动解密)
func load_data_encryptioned_automatic(path):
	var loader = File.new()
	loader.open_encrypted_with_pass(path, File.READ, OS.get_unique_id())
	# 读取json
	var json = parse_json(loader.get_as_text())
	# 关闭
	loader.close()
	return json

# 保存函数(自动加密)
func save_data_encryptioned_automatic(path, game_data):
	var saver = File.new()
	saver.open_encrypted_with_pass(path, File.WRITE, OS.get_unique_id())
	# 写入
	saver.store_line(to_json(game_data))
	# 关闭
	saver.close()
	return true

# 读取函数(解密)
func load_data_encryptioned(path, password):
	var loader = File.new()
	loader.open_encrypted_with_pass(path, File.READ, password)
	# 读取json
	var json = parse_json(loader.get_as_text())
	# 关闭
	loader.close()
	return json

# 保存函数(自动加密)
func save_data_encryptioned(path, game_data, password):
	var saver = File.new()
	saver.open_encrypted_with_pass(path, File.WRITE, password)
	# 写入
	saver.store_line(to_json(game_data))
	# 关闭
	saver.close()
	return true
