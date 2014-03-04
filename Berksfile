site :opscode

group :servertemplate do
  cookbook "ephemeral_lvm",
    git: "git://github.com/rightscale-cookbooks/ephemeral_lvm.git",
    ref: '30339df6aa83c0bb825489eeacd6c82fd030c701'

  cookbook "rs-machine_tag",
    git: "git://github.com/rightscale-cookbooks/rs-machine_tag.git"

  cookbook "machine_tag",
    git: "git://github.com/rightscale-cookbooks/machine_tag.git"

  cookbook "rs-base",
    git: "git://github.com/rightscale-cookbooks/rs-base.git"

  cookbook "marker",
    git: "git://github.com/rightscale-cookbooks/marker.git"

  cookbook 'collectd',
    github: 'EfrainOlivares/chef-collectd',
    ref: 'ec50609ed6eb193e0411f30aced91befa571940f'

  cookbook "application_ruby",
    github: "rgeyer-rs-cookbooks/application_ruby",
    ref: "COOK-4395"

  cookbook "route53",
    github: "rgeyer-rs-cookbooks/route53",
    ref: "needs_build_essential"

  cookbook "rs_ci_app_rails",
    path: "./cookbook-rs_ci_app_rails"
end

group :vagrant_only do
  cookbook "yum"

  cookbook "yum-epel"

  cookbook "rightscaleshim",
    path: "/Users/ryangreyer/Code/Chef/rgeyer-rs-cookbooks/rightscaleshim"

  cookbook "resolver"
end
