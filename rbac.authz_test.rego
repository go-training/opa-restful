package rbac.authz

acl = {
	"group_roles": {
		"admin": ["admin"],
		"quality_head_design": ["quality_head_design"],
		"quality_head_system": ["quality_head_system"],
		"quality_head_manufacture": ["quality_head_manufacture"],
		"kpi_editor_design": ["kpi_editor_design"],
		"kpi_editor_system": ["kpi_editor_system"],
		"kpi_editor_manufacture": ["kpi_editor_manufacture"],
		"viewer": ["viewer"],
		"viewer_limit_ds": ["viewer_limit_ds"],
		"viewer_limit_m": ["viewer_limit_m"],
		"design_group_kpi_editor": ["kpi_editor_design", "viewer_limit_ds"],
		"system_group_kpi_editor": ["kpi_editor_system", "viewer_limit_ds"],
		"manufacture_group_kpi_editor": ["kpi_editor_manufacture", "viewer"],
		"project_leader": ["viewer_limit_ds", "viewer_limit_m"],
	},
	"role_permissions": {
		"admin": [
			{"action": "view_all", "object": "design"},
			{"action": "edit", "object": "design"},
			{"action": "view_all", "object": "system"},
			{"action": "edit", "object": "system"},
			{"action": "view_all", "object": "manufacture"},
			{"action": "edit", "object": "manufacture"},
		],
		"quality_head_design": [
			{"action": "view_all", "object": "design"},
			{"action": "edit", "object": "design"},
			{"action": "view_all", "object": "system"},
			{"action": "view_all", "object": "manufacture"},
		],
		"quality_head_system": [
			{"action": "view_all", "object": "design"},
			{"action": "view_all", "object": "system"},
			{"action": "edit", "object": "system"},
			{"action": "view_all", "object": "manufacture"},
		],
		"quality_head_manufacture": [
			{"action": "view_all", "object": "design"},
			{"action": "view_all", "object": "system"},
			{"action": "view_all", "object": "manufacture"},
			{"action": "edit", "object": "manufacture"},
		],
		"kpi_editor_design": [
			{"action": "view_all", "object": "design"},
			{"action": "edit", "object": "design"},
		],
		"kpi_editor_system": [
			{"action": "view_all", "object": "system"},
			{"action": "edit", "object": "system"},
		],
		"kpi_editor_manufacture": [
			{"action": "view_all", "object": "manufacture"},
			{"action": "edit", "object": "manufacture"},
		],
		"viewer": [
			{"action": "view_all", "object": "design"},
			{"action": "view_all", "object": "system"},
			{"action": "view_all", "object": "manufacture"},
		],
		"viewer_limit_ds": [
			{"action": "view_all", "object": "design"},
			{"action": "view_all", "object": "system"},
		],
		"viewer_limit_m": [{"action": "view_l3_project", "object": "manufacture"}],
	},
}

test_design_group_kpi_editor {
	allow with input as {"user": ["design_group_kpi_editor"], "action": "view_all", "object": "design"} with data.rbac.authz.acl as acl
	allow with input as {"user": ["design_group_kpi_editor"], "action": "edit", "object": "design"} with data.rbac.authz.acl as acl
	allow with input as {"user": ["design_group_kpi_editor"], "action": "view_all", "object": "system"} with data.rbac.authz.acl as acl
	not allow with input as {"user": ["design_group_kpi_editor"], "action": "edit", "object": "system"} with data.rbac.authz.acl as acl
	not allow with input as {"user": ["design_group_kpi_editor"], "action": "view_all", "object": "manufacture"} with data.rbac.authz.acl as acl
	not allow with input as {"user": ["design_group_kpi_editor"], "action": "edit", "object": "manufacture"} with data.rbac.authz.acl as acl
}

test_system_group_kpi_editor {
	allow with input as {"user": ["system_group_kpi_editor"], "action": "view_all", "object": "design"} with data.rbac.authz.acl as acl
	not allow with input as {"user": ["system_group_kpi_editor"], "action": "edit", "object": "design"} with data.rbac.authz.acl as acl
	allow with input as {"user": ["system_group_kpi_editor"], "action": "view_all", "object": "system"} with data.rbac.authz.acl as acl
	allow with input as {"user": ["system_group_kpi_editor"], "action": "edit", "object": "system"} with data.rbac.authz.acl as acl
	not allow with input as {"user": ["system_group_kpi_editor"], "action": "view_all", "object": "manufacture"} with data.rbac.authz.acl as acl
	not allow with input as {"user": ["system_group_kpi_editor"], "action": "edit", "object": "manufacture"} with data.rbac.authz.acl as acl
}

test_manufacture_group_kpi_editor {
	allow with input as {"user": ["manufacture_group_kpi_editor"], "action": "view_all", "object": "design"} with data.rbac.authz.acl as acl
	not allow with input as {"user": ["manufacture_group_kpi_editor"], "action": "edit", "object": "design"} with data.rbac.authz.acl as acl
	allow with input as {"user": ["manufacture_group_kpi_editor"], "action": "view_all", "object": "system"} with data.rbac.authz.acl as acl
	not allow with input as {"user": ["manufacture_group_kpi_editor"], "action": "edit", "object": "system"} with data.rbac.authz.acl as acl
	allow with input as {"user": ["manufacture_group_kpi_editor"], "action": "view_all", "object": "manufacture"} with data.rbac.authz.acl as acl
	allow with input as {"user": ["manufacture_group_kpi_editor"], "action": "edit", "object": "manufacture"} with data.rbac.authz.acl as acl
}

test_project_leader {
	allow with input as {"user": ["project_leader"], "action": "view_all", "object": "design"} with data.rbac.authz.acl as acl
	not allow with input as {"user": ["project_leader"], "action": "edit", "object": "design"} with data.rbac.authz.acl as acl
	allow with input as {"user": ["project_leader"], "action": "view_all", "object": "system"} with data.rbac.authz.acl as acl
	not allow with input as {"user": ["project_leader"], "action": "edit", "object": "system"} with data.rbac.authz.acl as acl
	not allow with input as {"user": ["project_leader"], "action": "view_all", "object": "manufacture"} with data.rbac.authz.acl as acl
	not allow with input as {"user": ["project_leader"], "action": "edit", "object": "manufacture"} with data.rbac.authz.acl as acl
	allow with input as {"user": ["project_leader"], "action": "view_l3_project", "object": "manufacture"} with data.rbac.authz.acl as acl
}

test_design_group_kpi_editor_and_system_group_kpi_editor {
	allow with input as {"user": ["design_group_kpi_editor", "system_group_kpi_editor"], "action": "edit", "object": "design"} with data.rbac.authz.acl as acl
	allow with input as {"user": ["design_group_kpi_editor", "system_group_kpi_editor"], "action": "edit", "object": "system"} with data.rbac.authz.acl as acl
}
