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
  $all_repos = resources_deep_merge($repos,lookup('yum::repos', { 'merge' => 'hash','default_value' => {}}))
  create_resources('yum::repo',$all_repos)
}
