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
  deep_merge($repos,lookup('yum::repos', { 'merge' => 'hash','default_value' => {}})).each |$repo,$vals| {
    yum::repo{
      $repo:
        * => $vals,
    }
  }
}
