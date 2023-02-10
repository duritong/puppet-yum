# install post transaction
class yum::centos::dnf_post_transaction {
  package{'python3-dnf-plugin-post-transaction-actions':
    ensure => present,
  }
}
