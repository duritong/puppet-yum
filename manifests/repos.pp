# repos Class
#
# a private class
#
# === Parameters
#
# $repos:: {} of yum::repo
#
class yum::repos(
  $repos = {},
) {
  $all_repos = resources_deep_merge($repos,hiera_hash('yum::repos',{}))
  create_resources('yum::repo',$all_repos)
}
