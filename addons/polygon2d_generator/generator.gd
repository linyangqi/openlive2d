# Add proper save states
# Project reload cause losing access to polygon2d
# Add weights generation

tool
extends Control

var editor : EditorInterface
var step := 10
var plugin
var polygon2d : Polygon2D
var is_active := false
var area : Dictionary
var props : Dictionary
var init_polygon2d_data : Dictionary
var memory = {}


func _enter_tree() -> void:
	$step/label.set_text(str(step))
	
	
func _ready() -> void:
	editor.get_selection().connect("selection_changed", self, '_on_node_changed')
	


func _on_node_changed():
	if _is_polygon_selected():
		_update_polygon2d()
		yield(get_tree(), "idle_frame")
		yield(get_tree(), "idle_frame")
		_end()
	

func _on_step_value_changed(value) -> void:
	step = value
	$step/label.set_text(str(step))


func _on_clear_pressed() -> void:
	_clear_polygon()
		
		
func _clear_polygon() -> void:
	if _is_polygon_selected():
		_update_polygon2d()
		if _is_polygon_in_memory():
			polygon2d.set_polygon(_get_polygon_in_memory())
		polygon2d.set_polygons([])
		polygon2d.set_internal_vertex_count(0)
		polygon2d.set_internal_vertex_count(0)
		polygon2d.set_uv(PoolVector2Array([]))
		_end()


func _get_polygon_in_memory() -> PoolVector2Array:
	if _is_polygon_in_memory():
		return memory[polygon2d.get_instance_id()]
	else:
		return PoolVector2Array([])


func _is_polygon_in_memory() -> bool:
	if memory.has(polygon2d.get_instance_id()):
		return true
	else:
		return false
		
		
func _remember_polygon2d() -> void:
	memory[polygon2d.get_instance_id()] = PoolVector2Array(polygon2d.get_polygon())


func _on_debug_pressed() -> void:
	if _is_polygon_selected():
		_update_polygon2d()
		_end()


func _on_undo_pressed() -> void:
	for ch in polygon2d.get_children():
		ch.queue_free()
	_end()
	_return_init_poly()


func _on_generate_polygon() -> void:
	if _is_polygon_selected():
		_clear_polygon()
		_update_polygon2d()
		yield(get_tree(), "idle_frame")
		yield(get_tree(), "idle_frame")
		_create_per_vert()
		_create_internal_vert()
		_triangulate_polygon()
		_end()


func _create_basic_poly() -> void:
	if polygon2d.get_polygon().size() < 2:
		var bm = BitMap.new()
		bm.create_from_image_alpha(polygon2d.texture.get_data())
		var rect = Rect2(0, 0, polygon2d.texture.get_width(), polygon2d.texture.get_height())
		var poly = bm.opaque_to_polygons(rect, 2)
		polygon2d.set_polygon(PoolVector2Array(poly[0]))
		polygon2d.set_polygons(PoolVector2Array(poly[0]))

		
func _on_add_points() -> void:
	if _is_polygon_selected():
		_update_polygon2d()
		yield(get_tree(), "idle_frame")
		yield(get_tree(), "idle_frame")
		_create_per_vert()
		_create_internal_vert()
		_end()


func _weigh_bones() -> void:
	var skeleton = polygon2d.get_node(polygon2d.skeleton)
	var weights = []
	
	weights.resize(polygon2d.get_bone_count())
	
	for b_i in range(polygon2d.get_bone_count()):
		weights[b_i] = []
		weights[b_i].resize(polygon2d.polygon.size())
	
	for i in range(polygon2d.polygon.size()):
		var point = polygon2d.polygon[i]
		var bones_data = []
		var dist_sum = 0
		
		for b_i in range(polygon2d.get_bone_count()):
			var bone = skeleton.get_bone(b_i)
			var dist = point.distance_to(bone.position)
			bones_data.append([b_i, dist, null])
			dist_sum += dist
		
		bones_data.sort_custom(self, '_sort_nearest_point')
		
		for b_i in range(polygon2d.get_bone_count()):
			var bone_d = bones_data[b_i]
			bone_d[2] = 1 - 1 / (dist_sum / (dist_sum - bone_d[1]))
			if bone_d[2] > .5:
				weights[b_i][i] = bone_d[2]
			else:
				weights[b_i][i] = 0
			
	
	for b_i in range(polygon2d.get_bone_count()):
		polygon2d.set_bone_weights(b_i, PoolRealArray(weights[b_i]))
		
	print(polygon2d.bones)


func _sort_nearest_point(a, b) -> bool:
	if a[1] < b[1]:
		return true
	else:
		return false


func _update_polygon2d() -> void:
	polygon2d = editor.get_selection().get_selected_nodes()[0]
	if not _is_polygon_in_memory():
		_remember_polygon2d()
	elif polygon2d.internal_vertex_count == 0 and polygon2d.get_polygons().size() == 0:
		_remember_polygon2d()
	_define_area()
	_set_props()
	_update_init_poly()
	
	
func _update_init_poly() -> void:
	init_polygon2d_data = {
		'polygon' : polygon2d.get_polygon(),
		'uv' : polygon2d.get_uv(),
		'vertex_colors' : polygon2d.get_vertex_colors(),
		'polygons' : polygon2d.get_polygons(),
		'internal_vertex_count' : polygon2d.get_internal_vertex_count()
	}
	
	
func _return_init_poly() -> void:
	polygon2d.polygon = init_polygon2d_data.polygon
	polygon2d.uv = init_polygon2d_data.uv
	polygon2d.vertex_colors = init_polygon2d_data.vertex_colors
	polygon2d.polygons = init_polygon2d_data.polygons
	polygon2d.internal_vertex_count = init_polygon2d_data.internal_vertex_count
	
	
func _end() -> void:
	if area.area:
		area.area.queue_free()
		area.area = null
	if area.coll:
		area.coll = null
	
	
func _set_props() -> void:
	var lim = area.limits
	props = {}
	props.size = Vector2(lim.max.x - lim.min.x, lim.max.y - lim.min.y)
	props.num = Vector2(int(props.size.x / step), int(props.size.y / step))
	
	
func _create_internal_vert() -> void:
	var limits = area.limits
	var coll = area.coll
	var in_vert_count = 0
	var new_vert = polygon2d.get_polygon()
	
	for y in range(props.num.y + 1): 
		for x in range(props.num.x + 1):
			var point = Vector2(limits.min.x + (x * step), limits.min.y + (y * step))
			if _is_point_in_area(point):
				var is_fit = true
				for vert in polygon2d.get_polygon():
					if point.distance_to(vert) < step / 3:
						is_fit = false
						break
				if is_fit:
					new_vert.append(point)
					in_vert_count += 1
	
	polygon2d.set_polygon(PoolVector2Array(new_vert))
	polygon2d.set_internal_vertex_count(in_vert_count)


func _define_area() -> Dictionary:
	area = {}
	area.area = Area2D.new()
	area.coll = CollisionPolygon2D.new()
	area.area.add_child(area.coll)
	polygon2d.add_child(area.area)
	var poly = polygon2d.get_polygon()
	poly.resize(polygon2d.get_polygon().size() - polygon2d.get_internal_vertex_count())
	area.coll.set_polygon(poly)
	area.limits = _find_area_limits()
	return area


func _triangulate_polygon() -> void:
	var polygon = polygon2d.get_polygon()
	var points = Array(Geometry.triangulate_delaunay_2d(polygon))
	var polygons = []
	
	for i in range(ceil(len(points) / 3)):
		var triangle = []
		for n in range(3):
			triangle.append(points.pop_front())
		var a = polygon[triangle[0]]
		var b = polygon[triangle[1]]
		var c = polygon[triangle[2]]
		
		if _is_line_in_area(a,b) and _is_line_in_area(b,c) and _is_line_in_area(c,a):
			polygons.append(PoolIntArray(triangle))
	
	polygon2d.set_polygons(polygons)
	
	
func _is_line_in_area(a, b) -> bool:
	if _is_point_in_area(a + (a.direction_to(b) + Vector2(.01,.01))) or _is_point_in_area(a + (a.direction_to(b) + Vector2(-.01,-.01))):
		return true
	else:
		return false


func _find_area_limits() -> Dictionary:
	var lim = { 
		'min': area.coll.polygon[0],
		'max': area.coll.polygon[0]
	}
	for point in area.coll.polygon:
		if point.x < lim.min.x:
			lim.min.x = point.x
		if point.x > lim.max.x:
			lim.max.x = point.x
		if point.y < lim.min.y:
			lim.min.y = point.y
		if point.y > lim.max.y:
			lim.max.y = point.y
	return lim
	
	
func _is_point_in_area(point) -> bool:
	var space = area.area.get_world_2d().get_direct_space_state()
	var results = space.intersect_point(point + polygon2d.position, 100, [], area.area.get_collision_layer(), false, true)
	for result in results:
		if result.collider == area.area:
			return true
	return false
	
	
func _create_per_vert() -> PoolVector2Array:
	var poly = []
	var init_size = polygon2d.polygon.size()
	for n in range(init_size):
		var next_n = n + 1 if init_size > n + 1 else 0
		var p1 = polygon2d.polygon[n]
		var p2 = polygon2d.polygon[next_n]
		var dir = p1.direction_to(p2)
		var dist = p1.distance_to(p2)
		var num = dist / step
		for _n in range(num + 1):
			var point = p1 + (dir * _n * step)
			if point.distance_to(p2) > step / 3:
				poly.append(point)
					
	polygon2d.set_polygon(PoolVector2Array(poly))
	return polygon2d.get_polygon()


func _is_polygon_selected() -> bool:
	if editor.get_selection().get_selected_nodes():
		var pre_poly = editor.get_selection().get_selected_nodes()[0]
		if pre_poly is Polygon2D:
			return true
		else:
			print('Polygon2d must be selected')
			return false
	else:
		print('Polygon2d must be selected')
		return false


