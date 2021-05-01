package rbac.authz

import data.rbac.authz.acl
import input

# logic that implements RBAC.
default allow = false

allow {
	# lookup the list of roles for the user
	roles := acl.group_roles[input.user[_]]

	# for each role in that list
	r := roles[_]

	# lookup the permissions list for role r
	permissions := acl.role_permissions[r]

	# for each permission
	p := permissions[_]

	# check if the permission granted to r matches the user's request
	p == {"action": input.action, "object": input.object}
}
